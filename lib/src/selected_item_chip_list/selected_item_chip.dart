import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_list_style/selecte_item_chip_style.dart';

/// A widget that displays a single selected item as a chip.
///
/// The [SelectedItemChip] widget takes a title and displays it inside a chip.
/// The chip can be styled using the [selecteItemChipStyle] parameter and can
/// be deleted by the user, triggering the [onDeleted] callback.
class SelectedItemChip extends StatelessWidget {
  /// Creates a [SelectedItemChip] widget.
  ///
  /// The [title] parameter must not be null.
  const SelectedItemChip({
    required this.title,
    this.selecteItemChipStyle = const SelectedItemChipStyle(),
    this.onDeleted,
    super.key,
  });

  /// The title to be displayed inside the chip.
  final String title;

  /// The style to be applied to the chip.
  final SelectedItemChipStyle selecteItemChipStyle;

  /// Callback function to be called when the chip is deleted.
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
        labelStyle: selecteItemChipStyle.labelStyle,
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
