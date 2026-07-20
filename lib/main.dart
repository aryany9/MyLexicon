import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/services/database_service.dart';
import 'core/theme/app_theme.dart';
import 'models/lexicon_entry.dart';
import 'models/lexicon_collection.dart';
import 'models/lexicon_type.dart';
import 'routes/app_router.dart';

// Provider to manage app theme mode
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  static const _themeKey = 'app_theme_mode';

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_themeKey);
    if (value != null) {
      state = ThemeMode.values.firstWhere(
        (e) => e.name == value,
        orElse: () => ThemeMode.system,
      );
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
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
    final router = appRouter;
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'MyLexicon',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
