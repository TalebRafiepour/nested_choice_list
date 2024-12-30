import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/selected_item_chip.dart';

class SeletedItemChipList extends StatelessWidget {
  const SeletedItemChipList({
    required this.selectedEntities,
    this.onDeleted,
    super.key,
  });

  final List<NestedChoiceEntity> selectedEntities;
  final Function(NestedChoiceEntity)? onDeleted;

  void scrollToEndOfList(ScrollController scrollController) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    });
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
