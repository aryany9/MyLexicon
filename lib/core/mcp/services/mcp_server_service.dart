import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:uuid/uuid.dart';

import 'package:mylexicon/core/mcp/executors/mcp_tool_executor.dart';
import 'package:mylexicon/core/mcp/models/mcp_messages.dart';
import 'package:mylexicon/core/mcp/models/mcp_tools.dart';

class McpServerService {
  final McpToolExecutor _executor;
  HttpServer? _server;
  final _uuid = const Uuid();
  final Map<String, StreamController<String>> _sessions = {};
  int? _port;
  String? _bearerToken;

  McpServerService(this._executor);

  int? get port => _port;
  bool get isRunning => _server != null;

  Future<void> start({
    required int targetPort,
    required String bearerToken,
    bool bypassLoopback = false,
  }) async {
    if (isRunning) return;

    _bearerToken = bearerToken;

    final router = Router()
      ..get('/sse', _handleSse)
      ..post('/sse', _handleMessages)
      ..post('/messages', _handleMessages)
      ..post('/message', _handleMessages)
      ..all('/<ignored|.*>', (Request request) {
        print('MCP SERVER: Catch-all 404 hit for ${request.method} ${request.requestedUri}');
        return Response.notFound('Not Found from Catch-All');
      });

    final handler = const Pipeline()
        .addMiddleware(_authMiddleware(bypassLoopback))
        .addHandler(router.call);

    try {
      _server = await shelf_io.serve(handler, InternetAddress.anyIPv4, targetPort);
    } catch (e) {
      if (e is SocketException && e.osError?.errorCode == 98) {
        _server = await shelf_io.serve(handler, InternetAddress.anyIPv4, 0);
      } else {
        rethrow;
      }
    }
    _port = _server?.port;
  }

  Future<void> stop() async {
    if (!isRunning) return;

    for (final controller in _sessions.values.toList()) {
      await controller.close();
    }
    _sessions.clear();

    await _server?.close(force: true);
    _server = null;
    _port = null;
    _bearerToken = null;
  }

  Middleware _authMiddleware(bool bypassLoopback) {
    return (Handler innerHandler) {
      return (Request request) async {
        final ip = (request.context['shelf.io.connection_info'] as HttpConnectionInfo?)?.remoteAddress.address;
        
        if (bypassLoopback && (ip == '127.0.0.1' || ip == '::1')) {
          return innerHandler(request);
        }

        final authHeader = request.headers['authorization'] ?? request.headers['Authorization'];
        String? token;

        if (authHeader != null && authHeader.startsWith('Bearer ')) {
          token = authHeader.substring(7);
        } else {
          token = request.url.queryParameters['token'];
        }

        if (token == null || token.isEmpty) {
          return Response(401, body: 'Missing or invalid authentication');
        }

        if (token != _bearerToken) {
          return Response(403, body: 'Invalid token');
        }

        return innerHandler(request);
      };
    };
  }

  Response _handleSse(Request request) {
    print('MCP SERVER: Received SSE connection request from ${request.url}');
    final sessionId = _uuid.v4();
    final controller = StreamController<String>();
    _sessions[sessionId] = controller;

    controller.onCancel = () {
      print('MCP SERVER: SSE session closed: $sessionId');
      _sessions.remove(sessionId);
    };

    final scheme = request.requestedUri.scheme;
    final host = request.requestedUri.host;
    final port = request.requestedUri.port;
    // Construct an absolute URL so the client doesn't guess wrong
    final endpointUrl = '$scheme://$host:$port/messages?sessionId=$sessionId';
    print('MCP SERVER: Sending endpoint URL: $endpointUrl');
    final initialMessage = 'event: endpoint\ndata: $endpointUrl\n\n';

    // Start sending data asynchronously
    Future.microtask(() {
      controller.add(initialMessage);
    });

    return Response.ok(
      controller.stream.transform(utf8.encoder),
      headers: {
        'Content-Type': 'text/event-stream',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive',
      },
      context: {'shelf.io.buffer_output': false},
    );
  }

  Future<Response> _handleMessages(Request request) async {
    print('MCP SERVER: Received POST request on ${request.requestedUri}');
    final sessionId = request.url.queryParameters['sessionId'] ?? (_sessions.isNotEmpty ? _sessions.keys.first : null);
    if (sessionId == null || !_sessions.containsKey(sessionId)) {
      print('MCP SERVER: Invalid or missing sessionId: $sessionId');
      return Response(400, body: 'Invalid or missing sessionId');
    }

    final bodyStr = await request.readAsString();
    print('MCP SERVER: Request body: $bodyStr');
    
    Map<String, dynamic> bodyJson;
    try {
      bodyJson = jsonDecode(bodyStr);
    } catch (_) {
      print('MCP SERVER: Invalid JSON body');
      return Response(400, body: 'Invalid JSON body');
    }

    McpRequest mcpRequest;
    try {
      mcpRequest = McpRequest.fromJson(bodyJson);
    } catch (_) {
      print('MCP SERVER: Invalid MCP Request format');
      return Response(400, body: 'Invalid MCP Request format');
    }

    print('MCP SERVER: Handling method: ${mcpRequest.method}');

    if (mcpRequest.method == 'initialize' || mcpRequest.method == 'server/discover') {
      final response = McpResponse(
        id: mcpRequest.id,
        result: {
          'protocolVersion': mcpRequest.params?['protocolVersion'] ?? mcpRequest.params?['_meta']?['io.modelcontextprotocol/protocolVersion'] ?? '2024-11-05',
          'capabilities': {
            'tools': {}
          },
          'serverInfo': {
            'name': 'mylexicon',
            'version': '1.3.0'
          }
        },
      );
      
      final responseJson = jsonEncode(response.toJson());
      final controller = _sessions[sessionId];
      if (controller != null && !controller.isClosed) {
        controller.add('event: message\ndata: $responseJson\n\n');
      }
      return Response.ok(responseJson, headers: {'Content-Type': 'application/json'});
    } else if (mcpRequest.method == 'notifications/initialized') {
      // It's a notification, no response required
      return Response.ok('{}', headers: {'Content-Type': 'application/json'});
    } else if (mcpRequest.method == 'tools/call') {
      try {
        final toolName = mcpRequest.params?['name'] as String;
        final args = (mcpRequest.params?['arguments'] as Map<String, dynamic>?) ?? {};
        
        final toolResult = await _executor.executeTool(toolName, args);
        
        final response = McpResponse(
          id: mcpRequest.id,
          result: toolResult,
        );
        
        final responseJson = jsonEncode(response.toJson());
        final controller = _sessions[sessionId];
        if (controller != null && !controller.isClosed) {
          controller.add('event: message\ndata: $responseJson\n\n');
        }
        
        return Response.ok(responseJson, headers: {'Content-Type': 'application/json'});
      } catch (e) {
        final errorResp = McpError(
          id: mcpRequest.id,
          code: -32603,
          message: 'Internal tool execution error: $e'
        );
        
        final errorJson = jsonEncode(errorResp.toJson());
        final controller = _sessions[sessionId];
        if (controller != null && !controller.isClosed) {
          controller.add('event: message\ndata: $errorJson\n\n');
        }
        
        return Response.ok(errorJson, headers: {'Content-Type': 'application/json'});
      }
    } else if (mcpRequest.method == 'tools/list') {
      final response = McpResponse(
        id: mcpRequest.id,
        result: {
          'tools': McpTools.allTools,
        },
      );
      
      final responseJson = jsonEncode(response.toJson());
      final controller = _sessions[sessionId];
      if (controller != null && !controller.isClosed) {
        controller.add('event: message\ndata: $responseJson\n\n');
      }
      return Response.ok(responseJson, headers: {'Content-Type': 'application/json'});
    }

    // Standard MCP method not found response
    String errorJson = '{}';
    if (mcpRequest.id != null) {
      final errorResp = McpError(
        id: mcpRequest.id,
        code: -32601,
        message: 'Method not found'
      );
      errorJson = jsonEncode(errorResp.toJson());
      
      final controller = _sessions[sessionId];
      if (controller != null && !controller.isClosed) {
        controller.add('event: message\ndata: $errorJson\n\n');
      }
    }

    return Response.ok(errorJson, headers: {'Content-Type': 'application/json'});
  }
}
