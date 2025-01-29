import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_choice_list.dart';
import 'package:nested_choice_list/src/nested_choice_list_item.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_item_style.dart';

/// A stateless widget that represents an item in a nested expansion
/// choice list.
///
/// This widget is used to display a single item within a nested expansion list,
/// allowing for hierarchical selection of choices.
///
/// Typically used in conjunction with other widgets to create a nested
/// structure where users can expand and collapse sections to make selections.
///
/// {@tool snippet}
/// Example usage:
///
/// ```dart
/// NestedExpansionChoiceListItem(
/// ...
/// );
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [NestedChoiceListItem], which is used to show items
/// which is not expandable.
///
class NestedExpansionChoiceListItem extends StatelessWidget {
  const NestedExpansionChoiceListItem({
    required this.item,
    this.itemStyle = const NestedListItemStyle(),
    this.enableMultiSelect = false,
    this.isChecked,
    this.onTapItem,
    this.onToggleSelection,
    this.itemLeadingBuilder,
    super.key,
  });

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

  /// A builder function that creates a leading widget for an item.
  ///
  /// This can be used to customize the leading widget of each item in the list.
  final ItemLeadingBuilder? itemLeadingBuilder;

  @override
  Widget build(BuildContext context) {
    if (item.hasChildren) {
      return Padding(
        padding: itemStyle.margin,
        child: Material(
          type: MaterialType.transparency,
          child: ExpansionTile(
            shape: itemStyle.shape,
            collapsedShape: itemStyle.shape,
            enabled: !item.isDisabled,
            backgroundColor: itemStyle.bgColor,
            leading: itemLeadingBuilder?.call(context, item),
            dense: itemStyle.dense,
            visualDensity: itemStyle.visualDensity,
            title: Text(
              item.label,
              style: itemStyle.labelStyle ??
                  Theme.of(context).textTheme.titleSmall,
            ),
            children: List.generate(
              item.children.length,
              (index) {
                final childItem = item.children[index];
                return Padding(
                  padding: const EdgeInsetsDirectional.only(start: 24),
                  child: NestedExpansionChoiceListItem(
                    item: childItem,
                    itemStyle: itemStyle,
                    itemLeadingBuilder: itemLeadingBuilder,
                    isChecked: isChecked,
                    enableMultiSelect: enableMultiSelect,
                    onTapItem: onTapItem,
                    onToggleSelection: onToggleSelection,
                  ),
                );
              },
            ),
          ),
        ),
      );
    } else {
      return NestedChoiceListItem(
        item: item,
        itemStyle: itemStyle,
        itemLeadingBuilder: itemLeadingBuilder,
        isChecked: isChecked?.call(item) ?? false,
        isMultiSelect: enableMultiSelect,
        onTapItem: onTapItem,
        onToggleSelection: onToggleSelection,
      );
    }
  }
}
