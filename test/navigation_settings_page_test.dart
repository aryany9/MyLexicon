import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mylexicon/features/settings/sub_pages/navigation_settings_page.dart';

void main() {
  Widget buildTestApp() {
    return const ProviderScope(
      child: MaterialApp(
        home: NavigationSettingsPage(),
      ),
    );
  }

  testWidgets('NavigationSettingsPage renders segmented button and switches views',
      (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    // Verify AppBar and SegmentedButton segments
    expect(find.text('Navigation & Features'), findsOneWidget);
    expect(find.text('Navigation'), findsOneWidget);
    expect(find.text('Features'), findsOneWidget);

    // Initial state: Navigation segment is active
    expect(find.text('Default launch screen'), findsWidgets);
    expect(find.text('Navigation Tab Order'), findsOneWidget);
    expect(find.byType(ReorderableListView), findsOneWidget);

    // Switch to Features segment
    await tester.tap(find.text('Features'));
    await tester.pumpAndSettle();

    // Verify Features content is visible and Navigation content is gone
    expect(find.text('Category & Feature Toggles'), findsOneWidget);
    expect(find.text('Words'), findsOneWidget);
    expect(find.text('Phrases'), findsOneWidget);
    expect(find.text('Idioms'), findsOneWidget);
    expect(find.text('Quotes'), findsOneWidget);
    expect(find.text('Collections'), findsOneWidget);
    expect(find.byType(ReorderableListView), findsNothing);

    // Switch back to Navigation segment
    await tester.tap(find.text('Navigation'));
    await tester.pumpAndSettle();

    expect(find.text('Default launch screen'), findsWidgets);
    expect(find.byType(ReorderableListView), findsOneWidget);
    expect(find.text('Category & Feature Toggles'), findsNothing);
  });

  testWidgets('Tapping Default launch screen opens bottom sheet and updates selection',
      (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    // Tap the preference row to open bottom sheet
    await tester.tap(find.text('Screen shown when MyLexicon opens'));
    await tester.pumpAndSettle();

    // Verify bottom sheet title and subtitle
    expect(find.text('Choose your starting screen'), findsOneWidget);

    // Verify checkmark is initially on Dashboard
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);

    // Tap on Words option inside bottom sheet
    final wordsInSheet = find.descendant(
      of: find.byType(BottomSheet),
      matching: find.text('Words'),
    );
    expect(wordsInSheet, findsOneWidget);
    await tester.tap(wordsInSheet);
    await tester.pumpAndSettle();

    // Verify bottom sheet is dismissed and preference row displays Words
    expect(find.text('Choose your starting screen'), findsNothing);
    final preferenceRowValue = find.descendant(
      of: find.byKey(const ValueKey('default_launch_screen_card')),
      matching: find.text('Words'),
    );
    expect(preferenceRowValue, findsOneWidget);
  });
}
