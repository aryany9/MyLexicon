import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mylexicon/core/constants/text_constants.dart';
import 'package:mylexicon/features/home/home_screen.dart';

void main() {
  group('DashboardTagsSection Tests', () {
    testWidgets('Renders nothing when tags list is empty', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DashboardTagsSection(tags: []),
          ),
        ),
      );

      expect(find.text(TextConstants.yourTags), findsNothing);
      expect(find.byType(ActionChip), findsNothing);
    });

    testWidgets('Restricts to 1 row when 3 or fewer tags exist',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DashboardTagsSection(tags: ['tag1', 'tag2', 'tag3']),
          ),
        ),
      );

      expect(find.text(TextConstants.yourTags), findsOneWidget);
      expect(find.byType(ActionChip), findsNWidgets(3));

      // Find the Column inside Scrollbar that holds the chip Rows
      final chipsColumn = tester.widget<Column>(
        find.descendant(
          of: find.byType(Scrollbar),
          matching: find.byType(Column),
        ),
      );
      final chipRows = chipsColumn.children.whereType<Row>().toList();
      expect(chipRows.length, equals(1));
    });

    testWidgets('Restricts to 2 rows when 4 to 7 tags exist', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DashboardTagsSection(
              tags: ['t1', 't2', 't3', 't4', 't5'],
            ),
          ),
        ),
      );

      expect(find.text(TextConstants.yourTags), findsOneWidget);
      expect(find.byType(ActionChip), findsNWidgets(5));

      final chipsColumn = tester.widget<Column>(
        find.descendant(
          of: find.byType(Scrollbar),
          matching: find.byType(Column),
        ),
      );
      final chipRows = chipsColumn.children.whereType<Row>().toList();
      expect(chipRows.length, equals(2));
    });

    testWidgets(
        'Restricts to max 3 rows and scrolls horizontally for large tag sets',
        (tester) async {
      final tagsList = List.generate(24, (i) => 'tag$i');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DashboardTagsSection(tags: tagsList),
          ),
        ),
      );

      expect(find.text(TextConstants.yourTags), findsOneWidget);
      expect(find.byType(ActionChip), findsNWidgets(24));

      final chipsColumn = tester.widget<Column>(
        find.descendant(
          of: find.byType(Scrollbar),
          matching: find.byType(Column),
        ),
      );
      final chipRows = chipsColumn.children.whereType<Row>().toList();
      // Strictly capped to max 3 rows!
      expect(chipRows.length, equals(3));

      // Verify horizontal scroll view
      final scrollFinder = find.byWidgetPredicate(
        (w) => w is SingleChildScrollView && w.scrollDirection == Axis.horizontal,
      );
      expect(scrollFinder, findsOneWidget);
    });

    testWidgets(
        'Even with 60 tags (sample data size), row count never exceeds 3',
        (tester) async {
      final largeTagList = List.generate(60, (i) => 'sample_tag_$i');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DashboardTagsSection(tags: largeTagList),
          ),
        ),
      );

      expect(find.text(TextConstants.yourTags), findsOneWidget);
      expect(find.byType(ActionChip), findsNWidgets(60));

      final chipsColumn = tester.widget<Column>(
        find.descendant(
          of: find.byType(Scrollbar),
          matching: find.byType(Column),
        ),
      );
      final chipRows = chipsColumn.children.whereType<Row>().toList();
      expect(chipRows.length, equals(3));
    });
  });
}
