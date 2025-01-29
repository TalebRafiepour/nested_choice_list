import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_choice_list.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_item_style.dart';

/// A widget that displays an item in a nested list view.
///
/// The [NestedChoiceListItem] widget can display an item as either a [ListTile]
/// ,[ExpansionTile], or [CheckboxListTile] depending on the [enableMultiSelect]
/// and [isExpandable] flags.
/// It supports various customization options through the [itemStyle] parameter.
class NestedChoiceListItem extends StatelessWidget {
  /// Creates a [NestedChoiceListItem] widget.
  ///
  /// The [item] parameter must not be null.
  const NestedChoiceListItem({
    required this.item,
    this.isExpandable = false,
    this.itemStyle = const NestedListItemStyle(),
    this.enableMultiSelect = false,
    this.isChecked,
    this.onTapItem,
    this.onToggleSelection,
    this.itemLeadingBuilder,
    super.key,
  });

  /// Whether the item support expandable mode.
  final bool isExpandable;

  /// The style to be applied to the list item.
  final NestedListItemStyle itemStyle;

  /// Whether the item supports multi-selection.
  final bool enableMultiSelect;

  /// The item to be displayed.
  final NestedChoiceEntity item;

  /// A callback function that takes a [NestedChoiceEntity] and returns a
  /// boolean value.
  /// This function is used to determine if a specific choice entity is checked.
  final bool Function(NestedChoiceEntity)? isChecked;

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
        child: Builder(
          builder: (_) {
            if (item.hasChildren) {
              if (isExpandable) {
                return _buildExpandableTile(context);
              } else {
                return _buildListTile(context);
              }
            } else {
              if (enableMultiSelect) {
                return _buildCheckboxListTile(context);
              } else {
                return _buildListTile(context);
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildExpandableTile(BuildContext context) {
    return ExpansionTile(
      shape: itemStyle.shape,
      collapsedShape: itemStyle.shape,
      enabled: !item.isDisabled,
      backgroundColor: itemStyle.bgColor,
      leading: itemLeadingBuilder?.call(context, item),
      dense: itemStyle.dense,
      visualDensity: itemStyle.visualDensity,
      title: Text(
        item.label,
        style: itemStyle.labelStyle ?? Theme.of(context).textTheme.titleSmall,
      ),
      children: item.children.map((childItem) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 24),
          child: NestedChoiceListItem(
            item: childItem,
            isExpandable: isExpandable,
            itemStyle: itemStyle,
            itemLeadingBuilder: itemLeadingBuilder,
            isChecked: isChecked,
            enableMultiSelect: enableMultiSelect,
            onTapItem: onTapItem,
            onToggleSelection: onToggleSelection,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildListTile(BuildContext context) {
    return ListTile(
      shape: itemStyle.shape,
      enabled: !item.isDisabled,
      tileColor: itemStyle.bgColor,
      leading: itemLeadingBuilder?.call(context, item),
      dense: itemStyle.dense,
      visualDensity: itemStyle.visualDensity,
      title: Text(
        item.label,
        style: itemStyle.labelStyle ?? Theme.of(context).textTheme.titleSmall,
      ),
      trailing: item.hasChildren ? itemStyle.trailingIcon : null,
      onTap: () {
        onTapItem?.call(item, context);
      },
    );
  }

  Widget _buildCheckboxListTile(BuildContext context) {
    return CheckboxListTile(
      value: isChecked?.call(item),
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
        style: itemStyle.labelStyle ?? Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
