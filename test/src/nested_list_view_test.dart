import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_list_view.dart';
import 'package:nested_choice_list/src/search_field/searchfield_position.dart';

void main() {
  group('NestedListView Tests', () {
    testWidgets('renders correctly with default parameters', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NestedListView(
            items: [NestedChoiceEntity(value: '1', label: 'Item 1')],
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('search functionality filters items correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NestedListView(
            items: [
              NestedChoiceEntity(value: '1', label: 'Item 1'),
              NestedChoiceEntity(value: '2', label: 'Item 2'),
            ],
            enableSearch: true,
            searchfieldPosition: SearchfieldPosition.top,
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Item 1');
      await tester.pumpAndSettle();

      // finds two items with the text 'Item 1' because the search query
      // is 'Item 1'
      expect(find.text('Item 1'), findsNWidgets(2));
      expect(find.text('Item 2'), findsNothing);
    });

    testWidgets('select-all functionality works as expected', (tester) async {
      bool isSelectedAll = false;
      await tester.pumpWidget(
        MaterialApp(
          home: NestedListView(
            items: const [
              NestedChoiceEntity(value: '1', label: 'Item 1'),
              NestedChoiceEntity(value: '2', label: 'Item 2'),
            ],
            enableMultiSelect: true,
            onSelectAllCallback: ({required isSelected, required items}) {
              isSelectedAll = isSelected;
            },
          ),
        ),
      );

      await tester.tap(find.text('Select all'));
      await tester.pump();

      expect(isSelectedAll, isTrue);
    });

    testWidgets('item tap callback is triggered', (tester) async {
      NestedChoiceEntity? tappedItem;
      await tester.pumpWidget(
        MaterialApp(
          home: NestedListView(
            items: const [NestedChoiceEntity(value: '1', label: 'Item 1')],
            onTapItem: (item, context) {
              tappedItem = item;
            },
          ),
        ),
      );

      await tester.tap(find.text('Item 1'));
      await tester.pump();

      expect(tappedItem?.label, 'Item 1');
    });

    testWidgets('item toggle selection callback is triggered', (tester) async {
      NestedChoiceEntity? toggledItem;
      await tester.pumpWidget(
        MaterialApp(
          home: NestedListView(
            items: const [NestedChoiceEntity(value: '1', label: 'Item 1')],
            enableMultiSelect: true,
            onToggleSelection: (item) {
              toggledItem = item;
            },
            onSelectAllCallback: ({required isSelected, required items}) {},
          ),
        ),
      );

      await tester.tap(find.text('Item 1'));
      await tester.pump();

      expect(toggledItem?.label, 'Item 1');
    });

    testWidgets('leading widget builder works correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: NestedListView(
            items: const [NestedChoiceEntity(value: '1', label: 'Item 1')],
            itemLeadingBuilder: (context, item, index) {
              return const Icon(Icons.star);
            },
            onSelectAllCallback: ({required isSelected, required items}) {},
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });
}
