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
                return ExpandableTile(
                  item: item,
                  isExpandable: isExpandable,
                  itemStyle: itemStyle,
                  itemLeadingBuilder: itemLeadingBuilder,
                  isChecked: isChecked,
                  enableMultiSelect: enableMultiSelect,
                  onTapItem: onTapItem,
                  onToggleSelection: onToggleSelection,
                );
              } else {
                return ListTileWidget(
                  item: item,
                  itemStyle: itemStyle,
                  itemLeadingBuilder: itemLeadingBuilder,
                  onTapItem: onTapItem,
                );
              }
            } else {
              if (enableMultiSelect) {
                return CheckboxListTileWidget(
                  item: item,
                  itemStyle: itemStyle,
                  isChecked: isChecked,
                  onToggleSelection: onToggleSelection,
                  itemLeadingBuilder: itemLeadingBuilder,
                );
              } else {
                return ListTileWidget(
                  item: item,
                  itemStyle: itemStyle,
                  itemLeadingBuilder: itemLeadingBuilder,
                  onTapItem: onTapItem,
                );
              }
            }
          },
        ),
      ),
    );
  }
}

class CheckboxListTileWidget extends StatelessWidget {
  const CheckboxListTileWidget({
    required this.item,
    required this.itemStyle,
    required this.isChecked,
    required this.onToggleSelection,
    required this.itemLeadingBuilder,
    super.key,
  });

  final NestedChoiceEntity item;
  final NestedListItemStyle itemStyle;
  final bool Function(NestedChoiceEntity)? isChecked;
  final Function(NestedChoiceEntity)? onToggleSelection;
  final ItemLeadingBuilder? itemLeadingBuilder;

  @override
  Widget build(BuildContext context) {
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

/// A stateless widget that represents a list tile item in a nested choice list.
///
/// This widget can be used to display a single item in a list with additional
/// customization options.
///
/// Example usage:
///
/// ```dart
/// ListTileWidget(
///   title: Text('Item 1'),
///   subtitle: Text('Subtitle 1'),
///   leading: Icon(Icons.label),
///   trailing: Icon(Icons.arrow_forward),
///   onTap: () {
///     // Handle tap event
///   },
/// );
/// ```
///
/// See also:
///
///  * [ListTile], which is a similar widget provided by the Flutter framework.
class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    required this.item,
    required this.itemStyle,
    required this.itemLeadingBuilder,
    required this.onTapItem,
    super.key,
  });

  final NestedChoiceEntity item;
  final NestedListItemStyle itemStyle;
  final ItemLeadingBuilder? itemLeadingBuilder;
  final Function(NestedChoiceEntity, BuildContext)? onTapItem;

  @override
  Widget build(BuildContext context) {
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
}

/// A stateless widget that represents an expandable tile.
///
/// This widget can be used to create a tile that expands and collapses
/// to show or hide additional content.
///
/// Typically used in lists where each item can be expanded to reveal
/// more details or options.
class ExpandableTile extends StatelessWidget {
  const ExpandableTile({
    required this.item,
    required this.isExpandable,
    required this.itemStyle,
    required this.itemLeadingBuilder,
    required this.isChecked,
    required this.enableMultiSelect,
    required this.onTapItem,
    required this.onToggleSelection,
    super.key,
  });

  final NestedChoiceEntity item;
  final bool isExpandable;
  final NestedListItemStyle itemStyle;
  final ItemLeadingBuilder? itemLeadingBuilder;
  final bool Function(NestedChoiceEntity)? isChecked;
  final bool enableMultiSelect;
  final Function(NestedChoiceEntity, BuildContext)? onTapItem;
  final Function(NestedChoiceEntity)? onToggleSelection;

  @override
  Widget build(BuildContext context) {
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
}
