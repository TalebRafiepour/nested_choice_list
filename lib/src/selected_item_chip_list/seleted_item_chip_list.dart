import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/selected_item_chip_list/selected_item_chip.dart';

/// A widget that displays a list of selected items as chips.
///
/// The [SeletedItemChipList] widget takes a set of [NestedChoiceEntity] objects
/// and displays them as chips in a horizontal scrollable list. Each chip can
/// be deleted by the user, triggering the [onDeleted] callback.
class SeletedItemChipList extends StatelessWidget {
  /// Creates a [SeletedItemChipList] widget.
  ///
  /// The [selectedEntities] parameter must not be null.
  const SeletedItemChipList({
    required this.selectedEntities,
    this.onDeleted,
    super.key,
  });

  /// The set of selected entities to be displayed as chips.
  final Set<NestedChoiceEntity> selectedEntities;

  /// Callback function to be called when a chip is deleted.
  ///
  /// The callback receives the deleted [NestedChoiceEntity] as a parameter.
  final Function(NestedChoiceEntity)? onDeleted;

  /// Scrolls the list to the end.
  ///
  /// This method is called to ensure that the list is scrolled to the end
  /// whenever it is built.
  void scrollToEndOfList(ScrollController scrollController) {
    scheduleMicrotask(
      () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    scrollToEndOfList(scrollController);
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: selectedEntities
            .map(
              (e) => SelectedItemChip(
                title: e.label,
                onDeleted: () {
                  onDeleted?.call(e);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
