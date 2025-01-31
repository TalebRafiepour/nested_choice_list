import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested_choice_list/nested_choice_list.dart';
import 'package:nested_choice_list/src/nested_choice_list_item.dart';

void main() {
  group('NestedChoiceList Tests', () {
    testWidgets('renders correctly with default parameters', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NestedChoiceList(
            items: [NestedChoiceEntity(value: '1', label: 'Item 1')],
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('search functionality filters items correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NestedChoiceList(
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

    testWidgets('select-all children functionality works as expected',
        (tester) async {
      bool isSelectedAll = false;
      await tester.pumpWidget(
        MaterialApp(
          home: NestedChoiceList(
            items: const [
              NestedChoiceEntity(
                label: 'Parent',
                children: [
                  NestedChoiceEntity(value: '1', label: 'Item 1'),
                  NestedChoiceEntity(value: '2', label: 'Item 2'),
                ],
              ),
            ],
            enableMultiSelect: true,
            onSelectionChange: (items) {
              isSelectedAll = items.length == 2;
            },
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      expect(isSelectedAll, isTrue);
    });

    testWidgets('item tap callback is triggered', (tester) async {
      NestedChoiceEntity? tappedItem;
      await tester.pumpWidget(
        MaterialApp(
          home: NestedChoiceList(
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
          home: NestedChoiceList(
            items: const [NestedChoiceEntity(value: '1', label: 'Item 1')],
            enableMultiSelect: true,
            onSelectionChange: (items) {
              selectedItems = items;
            },
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      expect(selectedItems.length, 1);
      expect(selectedItems.first.label, 'Item 1');
    });

    testWidgets('leading widget builder works correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: NestedChoiceList(
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
          home: NestedChoiceList(
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
          home: NestedChoiceList(
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
          home: NestedChoiceList(
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

  testWidgets(
      'onExpansionChanged updates navigationPathes and triggers callback',
      (tester) async {
    bool isExpand = false;
    NestedChoiceEntity? expandedItem;

    await tester.pumpWidget(
      MaterialApp(
        home: NestedChoiceList(
          items: const [
            NestedChoiceEntity(value: '1', label: 'Item 1'),
          ],
          onExpansionChanged: ({required isExpanded, required item}) {
            isExpand = isExpanded;
            expandedItem = item;
          },
        ),
      ),
    );

    final state =
        tester.state<NestedChoiceListState>(find.byType(NestedChoiceList))
          ..onExpansionChanged(
            isExpanded: true,
            item: const NestedChoiceEntity(value: '1', label: 'Item 1'),
          );

    expect(state.navigationPathes, contains('Item 1'));
    expect(isExpand, isTrue);
    expect(expandedItem?.label, 'Item 1');
  });

  testWidgets('onSelectAllCallback updates selectedItems and triggers callback',
      (tester) async {
    List<NestedChoiceEntity> selectedItems = [];

    await tester.pumpWidget(
      MaterialApp(
        home: NestedChoiceList(
          items: const [
            NestedChoiceEntity(value: '1', label: 'Item 1'),
            NestedChoiceEntity(value: '2', label: 'Item 2'),
          ],
          enableMultiSelect: true,
          onSelectionChange: (items) {
            selectedItems = items;
          },
        ),
      ),
    );

    final state =
        tester.state<NestedChoiceListState>(find.byType(NestedChoiceList));
    state.onSelectAllCallback(isSelected: true, items: state.widget.items);

    expect(selectedItems.length, 2);
    expect(
      selectedItems.map((e) => e.label),
      containsAll(['Item 1', 'Item 2']),
    );
  });

  testWidgets(
      'onPopInvokedWithResult updates navigationPathes and triggers callback',
      (tester) async {
    int navigationPageIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: NestedChoiceList(
          items: const [
            NestedChoiceEntity(value: '1', label: 'Item 1'),
          ],
          onNavigationChange: (pageIndex) {
            navigationPageIndex = pageIndex;
          },
        ),
      ),
    );

    final state =
        tester.state<NestedChoiceListState>(find.byType(NestedChoiceList));
    state.navigationPathes.add('Item 1');
    state.onPopInvokedWithResult();

    expect(state.navigationPathes, isEmpty);
    expect(navigationPageIndex, 0);
  });

  testWidgets('onNavigationPathTapped navigates correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: NestedChoiceList(
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

    final state =
        tester.state<NestedChoiceListState>(find.byType(NestedChoiceList));
    state.navigationPathes.addAll(['Item 1', 'Item 1.1']);
    await state.onNavigationPathTapped(0);
    await tester.pumpAndSettle();

    expect(state.navigationPathes, ['Item 1']);
  });

  testWidgets('onToggleSelection updates selectedItems and triggers callback',
      (tester) async {
    List<NestedChoiceEntity> selectedItems = [];

    await tester.pumpWidget(
      MaterialApp(
        home: NestedChoiceList(
          items: const [
            NestedChoiceEntity(value: '1', label: 'Item 1'),
          ],
          enableMultiSelect: true,
          onSelectionChange: (items) {
            selectedItems = items;
          },
        ),
      ),
    );

    tester
        .state<NestedChoiceListState>(find.byType(NestedChoiceList))
        .onToggleSelection(
          item: const NestedChoiceEntity(value: '1', label: 'Item 1'),
          isChecked: true,
        );

    expect(selectedItems.length, 1);
    expect(selectedItems.first.label, 'Item 1');
  });

  testWidgets('onTapItem handles item taps correctly', (tester) async {
    NestedChoiceEntity? tappedItem;

    const childItem = NestedChoiceEntity(value: '1.1', label: 'Item 1.1');

    const parentItem = NestedChoiceEntity(
      value: '1',
      label: 'Item 1',
      children: [
        childItem,
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: NestedChoiceList(
          items: const [
            parentItem,
          ],
          onTapItem: (item) {
            tappedItem = item;
          },
        ),
      ),
    );

    final state =
        tester.state<NestedChoiceListState>(find.byType(NestedChoiceList))
          ..onTapItem(
            parentItem,
            tester.element(find.byType(NestedChoiceListItem)),
          );
    await tester.pumpAndSettle();

    expect(state.navigationPathes, contains(parentItem.label));
    expect(tappedItem, isNull);

    state.onTapItem(
      childItem,
      tester.element(find.byType(NestedChoiceList)),
    );

    await tester.pumpAndSettle();

    expect(tappedItem?.label, childItem.label);
  });
}
