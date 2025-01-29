import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_navigation_choice_list/nested_navigation_choice_list.dart';
import 'package:nested_choice_list/src/search_field/searchfield_position.dart';

void main() {
  group('NestedNavigationChoiceList Tests', () {
    testWidgets('renders correctly with default parameters', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NestedNavigationChoiceList(
            items: [NestedChoiceEntity(value: '1', label: 'Item 1')],
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('search functionality filters items correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NestedNavigationChoiceList(
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

      expect(find.text('Item 1'), findsNWidgets(2));
      expect(find.text('Item 2'), findsNothing);
    });

    testWidgets('select-all functionality works as expected', (tester) async {
      bool isSelectedAll = false;
      await tester.pumpWidget(
        MaterialApp(
          home: NestedNavigationChoiceList(
            items: const [
              NestedChoiceEntity(value: '1', label: 'Item 1'),
              NestedChoiceEntity(value: '2', label: 'Item 2'),
            ],
            enableMultiSelect: true,
            onSelectionChange: (items) {
              isSelectedAll = items.length == 2;
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
          home: NestedNavigationChoiceList(
            items: const [NestedChoiceEntity(value: '1', label: 'Item 1')],
            onTapItem: (item) {
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
      List<NestedChoiceEntity> selectedItems = [];
      await tester.pumpWidget(
        MaterialApp(
          home: NestedNavigationChoiceList(
            items: const [NestedChoiceEntity(value: '1', label: 'Item 1')],
            enableMultiSelect: true,
            onSelectionChange: (items) {
              selectedItems = items;
            },
          ),
        ),
      );

      await tester.tap(find.text('Item 1'));
      await tester.pump();

      expect(selectedItems.length, 1);
      expect(selectedItems.first.label, 'Item 1');
    });

    testWidgets('leading widget builder works correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: NestedNavigationChoiceList(
            items: const [NestedChoiceEntity(value: '1', label: 'Item 1')],
            itemLeadingBuilder: (context, item) {
              return const Icon(Icons.star);
            },
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('navigation path is displayed correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NestedNavigationChoiceList(
            items: [
              NestedChoiceEntity(
                value: '1',
                label: 'Item 1',
                children: [
                  NestedChoiceEntity(value: '1.1', label: 'Item 1.1'),
                ],
              ),
            ],
            showNavigationPath: true,
          ),
        ),
      );

      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 1.1'), findsOneWidget);
    });

    testWidgets('onNavigationChange callback is triggered', (tester) async {
      int navigationPageIndex = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: NestedNavigationChoiceList(
            items: const [
              NestedChoiceEntity(
                value: '1',
                label: 'Item 1',
                children: [
                  NestedChoiceEntity(value: '1.1', label: 'Item 1.1'),
                ],
              ),
            ],
            onNavigationChange: (pageIndex) {
              navigationPageIndex = pageIndex;
            },
          ),
        ),
      );

      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();

      expect(navigationPageIndex, 1);
    });

    testWidgets('selected items chip list is displayed correctly',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NestedNavigationChoiceList(
            items: [
              NestedChoiceEntity(value: '1', label: 'Item 1'),
              NestedChoiceEntity(value: '2', label: 'Item 2'),
            ],
            enableMultiSelect: true,
            selectedItems: [NestedChoiceEntity(value: '1', label: 'Item 1')],
          ),
        ),
      );

      expect(find.text('Item 1'), findsNWidgets(2));
      expect(find.text('Item 2'), findsOneWidget);
    });
  });
}
