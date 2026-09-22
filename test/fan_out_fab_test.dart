import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mylexicon/widgets/fan_out_fab.dart';

void main() {
  Widget buildTestApp({required VoidCallback onBackgroundTap}) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: ElevatedButton(
              key: const ValueKey('background_button'),
              onPressed: onBackgroundTap,
              child: const Text('Background Item'),
            ),
          ),
          floatingActionButton: const FanOutFab(),
        ),
      ),
    );
  }

  testWidgets(
      'FanOutFab displays backdrop blur barrier when opened and intercepts taps outside',
      (tester) async {
    int backgroundTapCount = 0;

    await tester.pumpWidget(
      buildTestApp(
        onBackgroundTap: () {
          backgroundTapCount++;
        },
      ),
    );
    await tester.pumpAndSettle();

    // Verify main FAB is visible, backdrop barrier is not
    expect(find.byKey(const ValueKey('fan_out_main_fab')), findsOneWidget);
    expect(find.byKey(const ValueKey('fan_out_backdrop_barrier')), findsNothing);

    // Tap background item while closed -> should register tap
    await tester.tap(find.byKey(const ValueKey('background_button')));
    await tester.pumpAndSettle();
    expect(backgroundTapCount, 1);

    // Tap FanOutFab to open
    await tester.tap(find.byKey(const ValueKey('fan_out_main_fab')));
    await tester.pumpAndSettle();

    // Verify overlay: backdrop barrier, options, and close button are now visible
    expect(find.byKey(const ValueKey('fan_out_backdrop_barrier')), findsOneWidget);
    expect(find.byType(BackdropFilter), findsWidgets);
    expect(find.text('Add Word'), findsOneWidget);
    expect(find.text('Add Phrase'), findsOneWidget);
    expect(find.text('Add Idiom'), findsOneWidget);
    expect(find.text('Add Quote'), findsOneWidget);
    expect(find.byKey(const ValueKey('fan_out_close_fab')), findsOneWidget);

    // Tap on background button location while FAB is open:
    // It should hit the backdrop barrier, close the FAB, and NOT increment backgroundTapCount!
    await tester.tap(
      find.byKey(const ValueKey('background_button')),
      warnIfMissed: false,
    );
    await tester.pumpAndSettle();

    // Background item should NOT have been tapped!
    expect(backgroundTapCount, 1);

    // Barrier should now be gone (closed)
    expect(find.byKey(const ValueKey('fan_out_backdrop_barrier')), findsNothing);
    expect(find.text('Add Word'), findsNothing);
  });

  testWidgets('Tapping close button on open FanOutFab closes the fan out',
      (tester) async {
    await tester.pumpWidget(buildTestApp(onBackgroundTap: () {}));
    await tester.pumpAndSettle();

    // Open FAB
    await tester.tap(find.byKey(const ValueKey('fan_out_main_fab')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('fan_out_close_fab')), findsOneWidget);

    // Tap close FAB
    await tester.tap(find.byKey(const ValueKey('fan_out_close_fab')));
    await tester.pumpAndSettle();

    // Verify closed
    expect(find.byKey(const ValueKey('fan_out_backdrop_barrier')), findsNothing);
  });
}
