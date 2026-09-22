import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mylexicon/core/providers/display_preferences_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('Default density is ListDensity.detailed', () {
    final notifier = ListDensityNotifier();
    expect(notifier.state, ListDensity.detailed);
  });

  test('Setting density updates state and persists string to SharedPreferences', () async {
    final notifier = ListDensityNotifier();

    await notifier.setDensity(ListDensity.compact);
    expect(notifier.state, ListDensity.compact);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('list_density'), 'compact');

    await notifier.setDensity(ListDensity.comfortable);
    expect(notifier.state, ListDensity.comfortable);
    expect(prefs.getString('list_density'), 'comfortable');

    await notifier.setDensity(ListDensity.detailed);
    expect(notifier.state, ListDensity.detailed);
    expect(prefs.getString('list_density'), 'detailed');
  });

  test('Recreating notifier with pre-populated SharedPreferences restores saved density', () async {
    SharedPreferences.setMockInitialValues({'list_density': 'compact'});

    final notifier = ListDensityNotifier();
    // Allow async _load() to run
    await Future<void>.delayed(Duration.zero);

    expect(notifier.state, ListDensity.compact);
  });

  test('ShowCardTagsNotifier defaults to true and persists toggles', () async {
    final notifier = ShowCardTagsNotifier();
    expect(notifier.state, true);

    await notifier.set(false);
    expect(notifier.state, false);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('show_card_tags'), false);

    await notifier.toggle();
    expect(notifier.state, true);
    expect(prefs.getBool('show_card_tags'), true);
  });

  test('ShowTypeBadgesNotifier defaults to true and persists toggles', () async {
    final notifier = ShowTypeBadgesNotifier();
    expect(notifier.state, true);

    await notifier.set(false);
    expect(notifier.state, false);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('show_type_badges'), false);

    await notifier.toggle();
    expect(notifier.state, true);
    expect(prefs.getBool('show_type_badges'), true);
  });

  test('FontFamilyNotifier defaults to system and persists changes', () async {
    final notifier = FontFamilyNotifier();
    expect(notifier.state, AppFontFamily.system);

    await notifier.setFont(AppFontFamily.serif);
    expect(notifier.state, AppFontFamily.serif);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('app_font_family'), 'serif');
  });

  test('TextScaleNotifier defaults to normal and persists changes', () async {
    final notifier = TextScaleNotifier();
    expect(notifier.state, AppTextScale.normal);

    await notifier.setScale(AppTextScale.large);
    expect(notifier.state, AppTextScale.large);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('app_text_scale'), 'large');
  });
}
