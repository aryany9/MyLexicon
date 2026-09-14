import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mylexicon/core/mcp/executors/mcp_tool_executor.dart';
import 'package:mylexicon/core/mcp/services/mcp_server_service.dart';
import 'package:mylexicon/core/services/database_service.dart';
import 'package:mylexicon/models/lexicon_entry.dart';
import 'package:mylexicon/models/lexicon_collection.dart';
import 'package:mylexicon/models/lexicon_type.dart';

void main() {
  late Directory tempDir;
  late Box<LexiconEntry> entriesBox;
  late Box<LexiconCollection> collectionsBox;
  late DatabaseService dbService;
  late McpToolExecutor executor;
  late McpServerService server;

  setUpAll(() {
    Hive.registerAdapter(LexiconTypeAdapter());
    Hive.registerAdapter(LexiconEntryAdapter());
    Hive.registerAdapter(LexiconCollectionAdapter());
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('mylexicon_mcp_server_test');
    Hive.init(tempDir.path);
    entriesBox = await Hive.openBox<LexiconEntry>('test_entries');
    collectionsBox = await Hive.openBox<LexiconCollection>('test_collections');
    dbService = DatabaseService(
      entriesBox: entriesBox,
      collectionsBox: collectionsBox,
    );
    executor = McpToolExecutor(dbService);
    server = McpServerService(executor);
  });

  tearDown(() async {
    await server.stop();
    await Hive.close();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('server starts on dynamic port and handles SSE lifecycle', () async {
    await server.start(targetPort: 0, bearerToken: 'test-token', bypassLoopback: true); // use dynamic port
    expect(server.isRunning, true);
    final port = server.port;
    expect(port, isNotNull);

    // Connect to /sse
    final client = HttpClient();
    final sseRequest = await client.getUrl(Uri.parse('http://127.0.0.1:$port/sse'));
    final sseResponse = await sseRequest.close();

    expect(sseResponse.statusCode, 200);
    expect(sseResponse.headers.contentType?.mimeType, 'text/event-stream');

    // Read the first chunk to get the endpoint event
    final stream = sseResponse.transform(utf8.decoder);
    String? endpointUrl;
    final sub = stream.listen((chunk) {
      if (chunk.contains('event: endpoint')) {
        final match = RegExp(r'data:\s*(/messages\?sessionId=[^\n]+)').firstMatch(chunk);
        if (match != null) {
          endpointUrl = match.group(1);
        }
      }
    });
    await Future.delayed(const Duration(milliseconds: 500));
    await sub.cancel();

    expect(endpointUrl, isNotNull);

    // Make a POST to the endpoint
    final postRequest = await client.postUrl(Uri.parse('http://127.0.0.1:$port$endpointUrl'));
    postRequest.headers.contentType = ContentType.json;
    postRequest.write(jsonEncode({
      'jsonrpc': '2.0',
      'id': 1,
      'method': 'tools/list',
    }));
    final postResponse = await postRequest.close();
    expect(postResponse.statusCode, 200);

    // We can also verify unauthorized behavior if token is required and loopback bypass is false
    client.close(force: true);
  });

  test('server requires Bearer token when bypass is false', () async {
    await server.start(targetPort: 0, bearerToken: 'secret123', bypassLoopback: false);
    final port = server.port;

    final client = HttpClient();
    final request = await client.getUrl(Uri.parse('http://127.0.0.1:$port/sse'));
    // No auth header
    final response = await request.close();

    expect(response.statusCode, 401);

    final requestWithAuth = await client.getUrl(Uri.parse('http://127.0.0.1:$port/sse'));
    requestWithAuth.headers.add('Authorization', 'Bearer secret123');
    final responseWithAuth = await requestWithAuth.close();

    expect(responseWithAuth.statusCode, 200);
    client.close(force: true);
  });
}
