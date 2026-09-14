import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/services/database_service.dart';
import 'core/theme/app_theme_registry.dart';
import 'core/providers/theme_preference_provider.dart';
import 'models/lexicon_entry.dart';
import 'models/lexicon_collection.dart';
import 'models/lexicon_type.dart';
import 'routes/app_router.dart';
import 'core/providers/tab_provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'core/mcp/services/mcp_background_service.dart';

// Global navigator key to allow navigation from outside widgets
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Local Notifications for Tap Handling
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher_monochrome');
  const initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  
  await flutterLocalNotificationsPlugin.initialize(
    settings: initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      if (response.payload == 'mcp_settings') {
        // Navigate to MCP Settings page directly when tapped
        final context = navigatorKey.currentContext;
        if (context != null) {
          context.go('/settings/mcp');
        }
      }
    },
  );

  // Initialize Background Service
  await initializeMcpBackgroundService();

  // Initialize Hive
  await Hive.initFlutter();
  
  // Register TypeAdapters
  Hive.registerAdapter(LexiconTypeAdapter());
  Hive.registerAdapter(LexiconEntryAdapter());
  Hive.registerAdapter(LexiconCollectionAdapter());
  
  // Open Hive Boxes
  final entriesBox = await Hive.openBox<LexiconEntry>('lexicon_entries');
  final collectionsBox = await Hive.openBox<LexiconCollection>('lexicon_collections');
  
  // Instantiate DatabaseService
  final databaseService = DatabaseService(
    entriesBox: entriesBox,
    collectionsBox: collectionsBox,
  );

  runApp(
    ProviderScope(
      overrides: [
        databaseServiceProvider.overrideWithValue(databaseService),
      ],
      child: const MyLexiconApp(),
    ),
  );
}

class MyLexiconApp extends ConsumerWidget {
  const MyLexiconApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialPath = ref.watch(defaultTabProvider);
    final router = useMemoizedRouter(initialPath);
    final themePref = ref.watch(appThemePreferenceProvider);

    final lightTheme = AppThemeRegistry.getTheme(themePref.lightThemeName);
    final darkTheme = AppThemeRegistry.getTheme(themePref.darkThemeName);

    return MaterialApp.router(
      title: 'MyLexicon',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themePref.mode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

GoRouter? _cachedRouter;
String? _cachedInitialPath;

GoRouter useMemoizedRouter(String initialPath) {
  if (_cachedRouter == null || _cachedInitialPath != initialPath) {
    _cachedInitialPath = initialPath;
    _cachedRouter = createAppRouter(initialLocation: initialPath);
  }
  return _cachedRouter!;
}
