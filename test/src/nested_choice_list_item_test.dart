import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_choice_list_item.dart';

void main() {
  group('NestedChoiceListItem Tests', () {
    testWidgets('renders correctly', (tester) async {
      const item = NestedChoiceEntity(value: '1', label: 'Item 1');

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NestedChoiceListItem(
              item: item,
            ),
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('handles tap events', (tester) async {
      const item = NestedChoiceEntity(value: '1', label: 'Item 1');
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NestedChoiceListItem(
              item: item,
              onTapItem: (item, context) {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Item 1'));
      expect(tapped, isTrue);
    });

    testWidgets('handles toggle selection', (tester) async {
      const item = NestedChoiceEntity(value: '1', label: 'Item 1');
      bool itemIsChecked = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NestedChoiceListItem(
              item: item,
              enableMultiSelect: true,
              isChecked: (item) => itemIsChecked,
              onToggleSelection: ({required item, required isChecked}) {
                itemIsChecked = isChecked;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      expect(itemIsChecked, isTrue);
    });

    testWidgets('handles expansion', (tester) async {
      const item = NestedChoiceEntity(
        value: '1',
        label: 'Item 1',
        children: [NestedChoiceEntity(value: '2', label: 'Child Item')],
      );
      bool expanded = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NestedChoiceListItem(
              item: item,
              isExpandable: true,
              onExpansionChanged: ({required item, required isExpanded}) {
                expanded = isExpanded;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();
      expect(expanded, isTrue);
      expect(find.text('Child Item'), findsOneWidget);
    });
  });
}
