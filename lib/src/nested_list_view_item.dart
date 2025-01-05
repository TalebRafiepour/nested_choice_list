import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_item_style.dart';

class NestedListViewItem extends StatelessWidget {
  const NestedListViewItem({
    required this.item,
    this.itemStyle = const NestedListItemStyle(),
    this.isMultiSelect = false,
    this.isChecked = false,
    this.onTapItem,
    this.onToggleSelection,
    this.leading,
    super.key,
  });

  final NestedListItemStyle itemStyle;
  final bool isMultiSelect;
  final NestedChoiceEntity item;
  final bool isChecked;
  final Function(NestedChoiceEntity, BuildContext)? onTapItem;
  final Function(NestedChoiceEntity)? onToggleSelection;
  final Widget? leading;

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
                secondary: leading,
                shape: itemStyle.shape,
                tileColor: itemStyle.bgColor,
                enabled: !item.isDisabled,
                title: Text(
                  item.label,
                  style: itemStyle.labelStyle ??
                      Theme.of(context).textTheme.titleMedium,
                ),
              )
            : ListTile(
                shape: itemStyle.shape,
                enabled: !item.isDisabled,
                tileColor: itemStyle.bgColor,
                leading: leading,
                title: Text(
                  item.label,
                  style: itemStyle.labelStyle ??
                      Theme.of(context).textTheme.titleMedium,
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
