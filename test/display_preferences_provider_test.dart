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
}
