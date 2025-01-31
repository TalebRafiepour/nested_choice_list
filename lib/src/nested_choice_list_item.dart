import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_choice_list.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_item_style.dart';

/// A typedef for a callback function that is triggered when the selection state
/// of a `NestedChoiceEntity` item is toggled.
///
/// The callback function takes two named parameters:
/// - `item`: The `NestedChoiceEntity` item whose selection state has changed.
/// - `isChecked`: A boolean indicating the new selection state of the item.
///
/// Example usage:
/// ```dart
/// void onToggleSelection({
/// required NestedChoiceEntity item,
/// required bool isChecked}) {
///   print('Item: ${item.name}, isChecked: $isChecked');
/// }
/// ```
typedef OnToggleSelection = void Function({
  required NestedChoiceEntity item,
  required bool isChecked,
});

/// A widget that displays an item in a nested list view.
///
/// The [NestedChoiceListItem] widget can display an item as either a [ListTile]
/// ,[ExpansionTile], or [CheckboxListTile] depending on the configuration.
///
/// This widget is typically used within a [NestedChoiceList] to represent
/// individual items that can be expanded or selected.
///
/// Example usage:
/// ```dart
/// NestedChoiceListItem(
///   item: myNestedChoiceEntity,
///   onToggleSelection: onToggleSelection,
///   style: NestedListItemStyle(),
/// )
/// ```
///
/// See also:
/// - [NestedChoiceEntity], which represents the data model for the item.
/// - [NestedChoiceList], which is the parent widget that contains the list of
///  items.
/// - [NestedListItemStyle], which defines the styling for the list item.

class NestedChoiceListItem extends StatelessWidget {
  const NestedChoiceListItem({
    required this.item,
    this.isExpandable = false,
    this.itemStyle = const NestedListItemStyle(),
    this.enableMultiSelect = false,
    this.isChecked,
    this.onTapItem,
    this.onToggleSelection,
    this.itemLeadingBuilder,
    this.onExpansionChanged,
    super.key,
  });

  /// Callback function that is triggered when the expansion state changes.
  final OnExpansionChanged? onExpansionChanged;

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

  /// Callback function to handle the toggle selection event.
  final OnToggleSelection? onToggleSelection;

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
                return _ExpandableTile(
                  item: item,
                  itemStyle: itemStyle,
                  itemLeadingBuilder: itemLeadingBuilder,
                  isChecked: isChecked,
                  enableMultiSelect: enableMultiSelect,
                  onTapItem: onTapItem,
                  onToggleSelection: onToggleSelection,
                  onExpansionChanged: onExpansionChanged,
                );
              } else {
                return _ListTileWidget(
                  item: item,
                  itemStyle: itemStyle,
                  isChecked: isChecked,
                  enableMultiSelect: enableMultiSelect,
                  onToggleSelection: onToggleSelection,
                  itemLeadingBuilder: itemLeadingBuilder,
                  onTapItem: onTapItem,
                );
              }
            } else {
              return _ListTileWidget(
                item: item,
                itemStyle: itemStyle,
                isChecked: isChecked,
                enableMultiSelect: enableMultiSelect,
                onToggleSelection: onToggleSelection,
                itemLeadingBuilder: itemLeadingBuilder,
                onTapItem: onTapItem,
              );
            }
          },
        ),
      ),
    );
  }
}

final class _ListTileWidget extends StatelessWidget {
  const _ListTileWidget({
    required this.item,
    required this.itemStyle,
    required this.enableMultiSelect,
    this.onTapItem,
    this.isChecked,
    this.onToggleSelection,
    this.itemLeadingBuilder,
  });

  final NestedChoiceEntity item;
  final NestedListItemStyle itemStyle;
  final bool Function(NestedChoiceEntity)? isChecked;
  final bool enableMultiSelect;
  final OnToggleSelection? onToggleSelection;
  final ItemLeadingBuilder? itemLeadingBuilder;
  final Function(NestedChoiceEntity, BuildContext)? onTapItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: itemStyle.dense,
      contentPadding: EdgeInsetsDirectional.only(
        start: hasLeading ? 0 : 16,
        end: 16,
      ),
      horizontalTitleGap: 0,
      leading: hasLeading
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (enableMultiSelect)
                  Checkbox.adaptive(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: isChecked?.call(item),
                    onChanged: (isSelected) {
                      onToggleSelection?.call(
                        item: item,
                        isChecked: isSelected ?? false,
                      );
                    },
                  ),
                if (itemLeadingBuilder != null)
                  itemLeadingBuilder!.call(context, item),
              ],
            )
          : null,
      shape: itemStyle.shape,
      tileColor: itemStyle.bgColor,
      enabled: !item.isDisabled,
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

  bool get hasLeading => enableMultiSelect || itemLeadingBuilder != null;
}

/// A stateless widget that represents an expandable tile.
///
/// This widget can be used to create a tile that expands and collapses
/// to show or hide additional content.
///
/// Typically used in lists where each item can be expanded to reveal
/// more details or options.
final class _ExpandableTile extends StatelessWidget {
  const _ExpandableTile({
    required this.item,
    required this.itemStyle,
    required this.itemLeadingBuilder,
    required this.isChecked,
    required this.enableMultiSelect,
    required this.onTapItem,
    required this.onToggleSelection,
    required this.onExpansionChanged,
  });

  final NestedChoiceEntity item;
  final NestedListItemStyle itemStyle;
  final ItemLeadingBuilder? itemLeadingBuilder;
  final bool Function(NestedChoiceEntity)? isChecked;
  final bool enableMultiSelect;
  final Function(NestedChoiceEntity, BuildContext)? onTapItem;
  final OnToggleSelection? onToggleSelection;
  final OnExpansionChanged? onExpansionChanged;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      horizontalTitleGap: 0,
      child: ExpansionTile(
        shape: itemStyle.shape,
        collapsedShape: itemStyle.shape,
        enabled: !item.isDisabled,
        backgroundColor: itemStyle.bgColor,
        tilePadding: EdgeInsets.only(
          right: 16,
          left: hasLeading ? 0 : 16,
        ),
        leading: hasLeading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (enableMultiSelect)
                    Checkbox.adaptive(
                      value: isChecked?.call(item),
                      onChanged: (isSelected) {
                        onToggleSelection?.call(
                          item: item,
                          isChecked: isSelected ?? false,
                        );
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  if (itemLeadingBuilder != null)
                    itemLeadingBuilder!.call(context, item),
                ],
              )
            : null,
        dense: itemStyle.dense,
        visualDensity: itemStyle.visualDensity,
        onExpansionChanged: (value) {
          onExpansionChanged?.call(isExpanded: value, item: item);
        },
        title: Text(
          item.label,
          style: itemStyle.labelStyle ?? Theme.of(context).textTheme.titleSmall,
        ),
        children: List.generate(item.children.length, (index) {
          final childItem = item.children[index];
          return Padding(
            padding: const EdgeInsetsDirectional.only(start: 24),
            child: NestedChoiceListItem(
              item: childItem,
              isExpandable: true,
              itemStyle: itemStyle,
              itemLeadingBuilder: itemLeadingBuilder,
              isChecked: isChecked,
              enableMultiSelect: enableMultiSelect,
              onTapItem: onTapItem,
              onToggleSelection: onToggleSelection,
              onExpansionChanged: onExpansionChanged,
            ),
          );
        }),
      ),
    );
  }

  bool get hasLeading => enableMultiSelect || itemLeadingBuilder != null;
}
