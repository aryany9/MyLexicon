import 'package:go_router/go_router.dart';
import '../core/shell/app_shell.dart';
import '../features/home/home_screen.dart';
import '../features/search/search_screen.dart';
import '../features/collections/collections_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/dictionary/entry_detail_screen.dart';
import '../features/dictionary/entry_form_screen.dart';
import '../features/dictionary/category_list_screen.dart';
import '../models/lexicon_type.dart';

GoRouter createAppRouter({String initialLocation = '/'}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          GoRoute(
            path: '/collections',
            builder: (context, state) => const CollectionsScreen(),
          ),
          GoRoute(
            path: '/category/:type',
            builder: (context, state) {
              final typeStr = state.pathParameters['type']!;
              final type = LexiconType.values.firstWhere(
                (t) => t.name == typeStr,
                orElse: () => LexiconType.word,
              );
              return CategoryListScreen(type: type);
            },
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/entry/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return EntryDetailScreen(entryId: id);
        },
      ),
      GoRoute(
        path: '/entry-form',
        builder: (context, state) {
          final entryId = state.uri.queryParameters['id'];
          final typeStr = state.uri.queryParameters['type'];
          LexiconType? initialType;
          if (typeStr != null) {
            try {
              initialType = LexiconType.values.firstWhere(
                (t) => t.name == typeStr,
              );
            } catch (_) {}
          }
          return EntryFormScreen(entryId: entryId, initialType: initialType);
        },
      ),
    ],
  );
}

final appRouter = createAppRouter();
