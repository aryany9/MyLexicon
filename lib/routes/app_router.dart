import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/home/home_screen.dart';
import '../features/search/search_screen.dart';
import '../features/collections/collections_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/dictionary/entry_detail_screen.dart';
import '../features/dictionary/entry_form_screen.dart';
import '../features/dictionary/category_list_screen.dart';
import '../models/lexicon_type.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/collections',
      builder: (context, state) => const CollectionsScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
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
        return EntryFormScreen(entryId: entryId);
      },
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
  ],
);
