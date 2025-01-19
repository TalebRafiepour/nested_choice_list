import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested_choice_list/src/inherited_nested_list_view.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';

void main() {
  group('InheritedNestedListView Tests', () {
    testWidgets('provides selected items correctly', (tester) async {
      final selectedItems = {
        const NestedChoiceEntity(value: '1', label: 'Item 1'),
      };

      await tester.pumpWidget(
        MaterialApp(
          home: InheritedNestedListView(
            selectedItems: selectedItems,
            child: Builder(
              builder: (context) {
                final inheritedWidget = InheritedNestedListView.of(context);
                expect(inheritedWidget?.selectedItems, selectedItems);
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('updates when selected items change', (tester) async {
      final selectedItems1 = {
        const NestedChoiceEntity(value: '1', label: 'Item 1'),
      };
      final selectedItems2 = {
        const NestedChoiceEntity(value: '2', label: 'Item 2'),
      };

      final testWidget = StatefulBuilder(
        builder: (context, setState) {
          return MaterialApp(
            home: InheritedNestedListView(
              selectedItems: selectedItems1,
              child: Builder(
                builder: (context) {
                  final inheritedWidget = InheritedNestedListView.of(context);
                  return Column(
                    children: [
                      Text(inheritedWidget?.selectedItems.first.label ?? ''),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            inheritedWidget?.selectedItems.clear();
                            inheritedWidget?.selectedItems
                                .addAll(selectedItems2);
                          });
                        },
                        child: const Text('Update Items'),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      );

      await tester.pumpWidget(testWidget);
      expect(find.text('Item 1'), findsOneWidget);

      await tester.tap(find.text('Update Items'));
      await tester.pump();

      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('retrieves nearest InheritedNestedListView widget',
        (tester) async {
      final selectedItems = {
        const NestedChoiceEntity(value: '1', label: 'Item 1'),
      };

      await tester.pumpWidget(
        MaterialApp(
          home: InheritedNestedListView(
            selectedItems: selectedItems,
            child: Builder(
              builder: (context) {
                final inheritedWidget = InheritedNestedListView.of(context);
                expect(inheritedWidget, isNotNull);
                return Container();
              },
            ),
          ),
        ),
      );
    });
  });
}
