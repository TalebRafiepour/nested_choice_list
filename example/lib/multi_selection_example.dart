import 'package:flutter/material.dart';
import 'package:nested_choice_list/nested_choice_list.dart';

class MultiSelectionExample extends StatelessWidget {
  const MultiSelectionExample({
    required this.items,
    this.selectedItems = const [],
    super.key,
  });
  final List<NestedChoiceEntity> items;
  final List<NestedChoiceEntity> selectedItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Nested Choice List with mulitple selection'),
      ),
      body: NestedChoiceList(
        items: items,
        isMultiSelect: true,
        onTapItem: (item) {
          debugPrint(item.toString());
        },
      ),
    );
  }
}
