import 'dart:async';
import 'dart:ui';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> initializeMcpBackgroundService() async {
  final service = FlutterBackgroundService();

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'mylexicon_mcp_channel',
    'MCP Server',
    description: 'Keeps the MCP server running in the background',
    importance: Importance.low, // Use low importance to avoid sound/pop-up
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
      notificationChannelId: 'mylexicon_mcp_channel',
      initialNotificationTitle: 'MCP Server is starting...',
      initialNotificationContent: 'Preparing network...',
      foregroundServiceNotificationId: 888,
      foregroundServiceTypes: [AndroidForegroundType.dataSync],
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();

    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    // Explicitly update the notification to make it ongoing and add a payload
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
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
          ongoing: true, // Prevents swiping it away
          autoCancel: false,
          importance: Importance.low,
        ),
      ),
      payload: 'mcp_settings',
    );
  }
}

@pragma('vm:entry-point')
bool onIosBackground(ServiceInstance service) {
  return true;
}
