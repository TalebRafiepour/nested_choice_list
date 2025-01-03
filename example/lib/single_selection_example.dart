import 'package:flutter/material.dart';
import 'package:nested_choice_list/nested_choice_list.dart';

class SingleSelectionExample extends StatelessWidget {
  const SingleSelectionExample({required this.items, super.key});

  final List<NestedChoiceEntity> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Nested Choice List with single selection'),
      ),
      body: NestedChoiceList(
        items: items,
        onTapItem: (item) {
          debugPrint(item.toString());
          Navigator.pop(context);
        },
      ),
    );
  }
}
