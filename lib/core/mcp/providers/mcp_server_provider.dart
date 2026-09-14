import 'dart:math';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mylexicon/core/mcp/executors/mcp_tool_executor.dart';
import 'package:mylexicon/core/mcp/services/mcp_server_service.dart';
import 'package:mylexicon/core/services/database_service.dart';

final mcpToolExecutorProvider = Provider<McpToolExecutor>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return McpToolExecutor(dbService);
});

final mcpServerServiceProvider = Provider<McpServerService>((ref) {
  final executor = ref.watch(mcpToolExecutorProvider);
  return McpServerService(executor);
});

class McpServerState {
  final bool isRunning;
  final int? port;
  final String bearerToken;
  
  const McpServerState({
    this.isRunning = false,
    this.port,
    this.bearerToken = '',
  });

  McpServerState copyWith({
    bool? isRunning,
    int? port,
    String? bearerToken,
  }) {
    return McpServerState(
      isRunning: isRunning ?? this.isRunning,
      port: port ?? this.port,
      bearerToken: bearerToken ?? this.bearerToken,
    );
  }
}

final mcpServerProvider = StateNotifierProvider<McpServerNotifier, McpServerState>((ref) {
  return McpServerNotifier(ref.watch(mcpServerServiceProvider));
});

class McpServerNotifier extends StateNotifier<McpServerState> {
  final McpServerService _service;

  McpServerNotifier(this._service) : super(const McpServerState()) {
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('mcp_bearer_token');
    if (token == null || token.isEmpty) {
      token = _generateToken();
      await prefs.setString('mcp_bearer_token', token);
    }
    state = state.copyWith(bearerToken: token);
  }

  String _generateToken() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return List.generate(16, (index) => chars[random.nextInt(chars.length)]).join();
  }

  Future<void> startServer() async {
    if (state.isRunning) return;

    // Request notification permission for Android 13+ so the persistent notification shows
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // Show the notification immediately to prevent any visual delay
    await flutterLocalNotificationsPlugin.show(
      id: 888,
      title: 'MCP Server is running',
      body: 'Accessible on your local network. Tap to turn off.',
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'mylexicon_mcp_channel',
          'MCP Server',
          icon: 'ic_launcher_monochrome',
          largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
          ongoing: true, // Attempt to prevent swiping
          autoCancel: false,
          importance: Importance.low,
        ),
      ),
      payload: 'mcp_settings',
    );

    await _service.start(
      targetPort: 8080,
      bearerToken: state.bearerToken,
      bypassLoopback: true,
    );

    // Start background service to keep process alive
    final bgService = FlutterBackgroundService();
    await bgService.startService();

    state = state.copyWith(
      isRunning: true,
      port: _service.port,
    );
  }

  Future<void> stopServer() async {
    if (!state.isRunning) return;

    await _service.stop();

    // Stop background service
    final bgService = FlutterBackgroundService();
    bgService.invoke('stopService');

    state = state.copyWith(
      isRunning: false,
      port: null,
    );
  }
}
