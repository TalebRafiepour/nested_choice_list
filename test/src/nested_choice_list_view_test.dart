import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_choice_list_type.dart';
import 'package:nested_choice_list/src/nested_choice_list_view.dart';
import 'package:nested_choice_list/src/search_field/searchfield_position.dart';

void main() {
  group('NestedChoiceListView Tests', () {
    testWidgets('renders correctly with default parameters', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NestedChoiceListView(
            items: [NestedChoiceEntity(value: '1', label: 'Item 1')],
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('search functionality filters items correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NestedChoiceListView(
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

    testWidgets('item tap callback is triggered', (tester) async {
      NestedChoiceEntity? tappedItem;
      await tester.pumpWidget(
        MaterialApp(
          home: NestedChoiceListView(
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
          home: NestedChoiceListView(
            items: const [NestedChoiceEntity(value: '1', label: 'Item 1')],
            enableMultiSelect: true,
            onToggleSelection: ({required item, required isChecked}) {
              toggledItem = item;
            },
            onSelectAllCallback: ({required isSelected, required items}) {},
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      expect(toggledItem?.label, 'Item 1');
    });

    testWidgets('leading widget builder works correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: NestedChoiceListView(
            items: const [NestedChoiceEntity(value: '1', label: 'Item 1')],
            itemLeadingBuilder: (context, item) {
              return const Icon(Icons.star);
            },
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });

  testWidgets('filters items correctly with nested children', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: NestedChoiceListView(
          items: [
            NestedChoiceEntity(
              value: '1',
              label: 'Parent 1',
              children: [
                NestedChoiceEntity(value: '1.1', label: 'Child 1.1'),
                NestedChoiceEntity(value: '1.2', label: 'Child 1.2'),
              ],
            ),
            NestedChoiceEntity(
              value: '2',
              label: 'Parent 2',
              children: [
                NestedChoiceEntity(value: '2.1', label: 'Child 2.1'),
                NestedChoiceEntity(value: '2.2', label: 'Child 2.2'),
              ],
            ),
          ],
          enableSearch: true,
          searchfieldPosition: SearchfieldPosition.top,
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Child 1.1');
    await tester.pumpAndSettle();

    expect(find.text('Parent 1'), findsOneWidget);
    expect(find.text('Child 1.1'), findsOneWidget);
    expect(find.text('Child 1.2'), findsNothing);
    expect(find.text('Parent 2'), findsNothing);
    expect(find.text('Child 2.1'), findsNothing);
    expect(find.text('Child 2.2'), findsNothing);
  });

  testWidgets('filters items correctly with no matches', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: NestedChoiceListView(
          items: [
            NestedChoiceEntity(value: '1', label: 'Item 1'),
            NestedChoiceEntity(value: '2', label: 'Item 2'),
          ],
          enableSearch: true,
          searchfieldPosition: SearchfieldPosition.top,
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Non-existent');
    await tester.pumpAndSettle();

    expect(find.text('Item 1'), findsNothing);
    expect(find.text('Item 2'), findsNothing);
  });

  testWidgets('selects items correctly', (tester) async {
    final Set<NestedChoiceEntity> selectedItems = {};
    await tester.pumpWidget(
      MaterialApp(
        home: NestedChoiceListView(
          items: const [
            NestedChoiceEntity(value: '1', label: 'Item 1'),
            NestedChoiceEntity(value: '2', label: 'Item 2'),
          ],
          enableMultiSelect: true,
          onToggleSelection: ({required item, required isChecked}) {
            if (isChecked) {
              selectedItems.add(item);
            } else {
              selectedItems.remove(item);
            }
          },
          onSelectAllCallback: ({required isSelected, required items}) {
            if (isSelected) {
              selectedItems.addAll(items);
            } else {
              selectedItems.clear();
            }
          },
        ),
      ),
    );

    await tester.tap(find.byType(Checkbox).first);
    await tester.pump();
    await tester.tap(find.byType(Checkbox).last);
    await tester.pump();

    expect(selectedItems.length, 2);
    expect(selectedItems.any((item) => item.label == 'Item 1'), isTrue);
    expect(selectedItems.any((item) => item.label == 'Item 2'), isTrue);
  });

  testWidgets('expansion state changes correctly', (tester) async {
    bool? expansionState;
    await tester.pumpWidget(
      MaterialApp(
        home: NestedChoiceListView(
          items: const [
            NestedChoiceEntity(
              value: '1',
              label: 'Parent 1',
              children: [
                NestedChoiceEntity(value: '1.1', label: 'Child 1.1'),
              ],
            ),
          ],
          type: NestedChoiceListType.expandable,
          onExpansionChanged: ({required item, required isExpanded}) {
            expansionState = isExpanded;
          },
        ),
      ),
    );

    await tester.tap(find.text('Parent 1'));
    await tester.pump();

    expect(expansionState, isTrue);
  });
}
