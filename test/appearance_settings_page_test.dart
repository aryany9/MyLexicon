import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mylexicon/features/settings/sub_pages/appearance_settings_page.dart';
import 'package:mylexicon/features/settings/sub_pages/theme_settings_page.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Widget buildTestApp() {
    return const ProviderScope(
      child: MaterialApp(
        home: AppearanceSettingsPage(),
      ),
    );
  }

  testWidgets(
      'AppearanceSettingsPage renders Theme tile and navigates to ThemeSettingsPage',
      (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    // Verify Theme tile is rendered
    expect(find.byKey(const ValueKey('theme_settings_tile')), findsOneWidget);
    expect(find.text('Theme'), findsWidgets);

    // Tap Theme tile
    await tester.tap(find.byKey(const ValueKey('theme_settings_tile')));
    await tester.pumpAndSettle();

    // Verify ThemeSettingsPage is pushed
    expect(find.byType(ThemeSettingsPage), findsOneWidget);
    expect(find.byKey(const ValueKey('theme_mode_segmented_button')), findsOneWidget);
    expect(find.text('☀ Light Mode Theme'), findsOneWidget);
    expect(find.text('🌙 Dark Mode Theme'), findsOneWidget);
  });

  testWidgets(
      'AppearanceSettingsPage renders Reddit-style Display density row and selects via bottom sheet',
      (tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    // Verify Display density row is rendered
    expect(find.byKey(const ValueKey('display_density_card')), findsOneWidget);
    expect(find.text('Display density'), findsOneWidget);

    // Initial density is Detailed
    final initialLabel = find.descendant(
      of: find.byKey(const ValueKey('display_density_card')),
      matching: find.text('Detailed'),
    );
    expect(initialLabel, findsOneWidget);

    // Tap Display density row to open bottom sheet
    await tester.tap(find.byKey(const ValueKey('display_density_card')));
    await tester.pumpAndSettle();

    // Verify Reddit-style bottom sheet title, circular close button, and options
    expect(find.byKey(const ValueKey('preference_picker_close_button')), findsOneWidget);
    expect(find.text('Show term only with minimal vertical padding'), findsOneWidget);
    expect(find.text('Show term and a short one-line definition'), findsOneWidget);
    expect(find.text('Show full details including examples and tags'), findsOneWidget);

    // Tap Compact option in bottom sheet
    final compactOption = find.descendant(
      of: find.byType(BottomSheet),
      matching: find.text('Compact'),
    );
    expect(compactOption, findsOneWidget);
    await tester.tap(compactOption);
    await tester.pumpAndSettle();

    // Verify sheet is dismissed and preference row updated to Compact
    expect(find.byKey(const ValueKey('preference_picker_close_button')), findsNothing);
    final updatedLabel = find.descendant(
      of: find.byKey(const ValueKey('display_density_card')),
      matching: find.text('Compact'),
    );
    expect(updatedLabel, findsOneWidget);
  });

  testWidgets(
      'Reddit-style bottom sheet close button dismisses sheet without changes',
      (tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    // Tap Display density row
    await tester.tap(find.byKey(const ValueKey('display_density_card')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('preference_picker_close_button')), findsOneWidget);

    // Tap close button (X)
    await tester.tap(find.byKey(const ValueKey('preference_picker_close_button')));
    await tester.pumpAndSettle();

    // Bottom sheet is dismissed
    expect(find.byKey(const ValueKey('preference_picker_close_button')), findsNothing);
  });
}
