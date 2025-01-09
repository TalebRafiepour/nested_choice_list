import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_list_style/selecte_item_chip_style.dart';

class SelectedItemChip extends StatelessWidget {
  const SelectedItemChip({
    required this.title,
    this.selecteItemChipStyle = const SelectedItemChipStyle(),
    this.onDeleted,
    super.key,
  });

  final String title;
  final SelectedItemChipStyle selecteItemChipStyle;
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: selecteItemChipStyle.margin,
      child: Chip(
        padding: selecteItemChipStyle.padding,
        color: selecteItemChipStyle.color ??
            WidgetStatePropertyAll(
              Theme.of(context).colorScheme.primary,
            ),
        elevation: selecteItemChipStyle.elevation,
        materialTapTargetSize: selecteItemChipStyle.materialTapTargetSize,
        deleteIcon: selecteItemChipStyle.deleteIcon,
        onDeleted: onDeleted,
        label: Text(
          title,
          style: selecteItemChipStyle.labelStyle ??
              Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                  ),
        ),
      ),
    );
  }
}
