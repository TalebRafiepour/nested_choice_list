import 'package:examples/main.dart';
import 'package:flutter/material.dart';
import 'package:nested_choice_list/nested_choice_list.dart';

class ExampleOne extends StatelessWidget {
  const ExampleOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NestedChoiceList - expandable'),
      ),
      body: NestedChoiceList(
        items: items,
        type: NestedChoiceListType.expandable,
        enableMultiSelect: true,
        style: const NestedListStyle(),
        // this callback triggers when we are in
        // single select mode (enableMultiSelect = false)
        onTapItem: (item) {
          debugPrint('onTapItem -> $item');
          Navigator.of(context).pop(item);
        },
        // this callback triggers when we are in
        // multi select mode (enableMultiSelect = true)
        onSelectionChange: (items) {
          debugPrint('onSelectionChange -> $items');
        },

        /// Callback function triggered when the navigation changes.
        /// Useful for handling UI updates based on the current page index.
        onNavigationChange: (pageIndex) {
          debugPrint('onNavigationChange -> pageIndex: $pageIndex');
        },
      ),
    );
  }
}
