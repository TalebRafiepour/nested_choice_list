import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/selected_item_chip_list/seleted_item_chip_list.dart';

void main() {
  group('SeletedItemChipList Tests', () {
    testWidgets('renders correctly with given entities', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SeletedItemChipList(
            selectedEntities: {
              const NestedChoiceEntity(value: '1', label: 'Item 1'),
              const NestedChoiceEntity(value: '2', label: 'Item 2'),
            },
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('onDeleted callback is triggered when a chip is deleted',
        (tester) async {
      NestedChoiceEntity? deletedEntity;
      await tester.pumpWidget(
        MaterialApp(
          home: SeletedItemChipList(
            selectedEntities: {
              const NestedChoiceEntity(value: '1', label: 'Item 1'),
              const NestedChoiceEntity(value: '2', label: 'Item 2'),
            },
            onDeleted: (entity) {
              deletedEntity = entity;
            },
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.close).first);
      await tester.pump();

      expect(deletedEntity?.label, 'Item 1');
    });

    testWidgets('list scrolls to the end when built', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SeletedItemChipList(
            selectedEntities: {
              const NestedChoiceEntity(value: '1', label: 'Item 1'),
              const NestedChoiceEntity(value: '2', label: 'Item 2'),
              const NestedChoiceEntity(value: '3', label: 'Item 3'),
              const NestedChoiceEntity(value: '4', label: 'Item 4'),
              const NestedChoiceEntity(value: '5', label: 'Item 5'),
            },
          ),
        ),
      );

      final scrollController = tester
          .widget<SingleChildScrollView>(find.byType(SingleChildScrollView))
          .controller!;
      expect(
        scrollController.position.pixels,
        scrollController.position.maxScrollExtent,
      );
    });
  });
}
