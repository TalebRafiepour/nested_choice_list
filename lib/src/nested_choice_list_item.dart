import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_choice_list.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_item_style.dart';

/// A widget that displays an item in a nested list view.
///
/// The [NestedChoiceListItem] widget can display an item as either
/// a [ListTile] or a [CheckboxListTile] depending on the [isMultiSelect] flag.
/// It supports various customization options through the [itemStyle] parameter.
class NestedChoiceListItem extends StatelessWidget {
  /// Creates a [NestedChoiceListItem] widget.
  ///
  /// The [item] parameter must not be null.
  const NestedChoiceListItem({
    required this.item,
    this.itemStyle = const NestedListItemStyle(),
    this.isMultiSelect = false,
    this.isChecked = false,
    this.onTapItem,
    this.onToggleSelection,
    this.itemLeadingBuilder,
    super.key,
  });

  /// The style to be applied to the list item.
  final NestedListItemStyle itemStyle;

  /// Whether the item supports multi-selection.
  final bool isMultiSelect;

  /// The item to be displayed.
  final NestedChoiceEntity item;

  /// Whether the item is checked (for multi-selection).
  final bool isChecked;

  /// Callback function to be called when the item is tapped.
  final Function(NestedChoiceEntity, BuildContext)? onTapItem;

  /// Callback function to be called when the item's selection is toggled.
  final Function(NestedChoiceEntity)? onToggleSelection;

  /// A builder function to create a leading widget for the item.
  ///
  /// This can be used to add a custom leading widget, such as an icon or image,
  /// to the item in the nested choice list.
  final ItemLeadingBuilder? itemLeadingBuilder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemStyle.margin,
      child: Material(
        type: MaterialType.transparency,
        child: isMultiSelect && !item.hasChildren
            ? CheckboxListTile(
                value: isChecked,
                onChanged: (isSelected) {
                  onToggleSelection?.call(item);
                },
                dense: itemStyle.dense,
                secondary: itemLeadingBuilder?.call(context, item),
                shape: itemStyle.shape,
                tileColor: itemStyle.bgColor,
                enabled: !item.isDisabled,
                visualDensity: itemStyle.visualDensity,
                title: Text(
                  item.label,
                  style: itemStyle.labelStyle ??
                      Theme.of(context).textTheme.titleSmall,
                ),
              )
            : ListTile(
                shape: itemStyle.shape,
                enabled: !item.isDisabled,
                tileColor: itemStyle.bgColor,
                leading: itemLeadingBuilder?.call(context, item),
                dense: itemStyle.dense,
                visualDensity: itemStyle.visualDensity,
                title: Text(
                  item.label,
                  style: itemStyle.labelStyle ??
                      Theme.of(context).textTheme.titleSmall,
                ),
                trailing: item.hasChildren ? itemStyle.trailingIcon : null,
                onTap: () {
                  onTapItem?.call(item, context);
                },
              ),
      ),
    );
  }
}
