import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/inherited_nested_list_view.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_item_style.dart';

class NestedListView extends StatelessWidget {
  const NestedListView({
    required this.items,
    required this.itemStyle,
    this.onPopInvokedWithResult,
    this.isMultiSelect = false,
    this.onTapItem,
    this.onToggleSelection,
    super.key,
  });

  final bool isMultiSelect;
  final List<NestedChoiceEntity> items;
  final NestedListItemStyle itemStyle;
  final Function(NestedChoiceEntity, BuildContext)? onTapItem;
  final Function(NestedChoiceEntity)? onToggleSelection;
  final PopInvokedWithResultCallback? onPopInvokedWithResult;

  @override
  Widget build(BuildContext context) {
    final selectedItems =
        InheritedNestedListView.of(context)?.selectedItems ?? [];
    return PopScope(
      onPopInvokedWithResult: onPopInvokedWithResult,
      child: items.isEmpty
          ? const Center(
              child: Icon(
                Icons.now_widgets_sharp,
                color: Color.fromARGB(255, 169, 168, 168),
                size: 48,
              ),
            )
          : ListView.builder(
              itemCount: items.length,
              padding: itemStyle.listPadding,
              itemBuilder: (_, index) {
                return Padding(
                  padding: itemStyle.margin,
                  child: Material(
                    type: MaterialType.transparency,
                    child: isMultiSelect && !items[index].hasChildren
                        ? CheckboxListTile(
                            value: selectedItems.contains(items[index]),
                            onChanged: (isSelected) {
                              onToggleSelection?.call(items[index]);
                            },
                            shape: itemStyle.shape,
                            fillColor:
                                WidgetStatePropertyAll(itemStyle.bgColor),
                            enabled: !items[index].isDisabled,
                            title: Text(
                              items[index].label,
                              style: itemStyle.labelStyle ??
                                  Theme.of(context).textTheme.titleMedium,
                            ),
                          )
                        : ListTile(
                            shape: itemStyle.shape,
                            enabled: !items[index].isDisabled,
                            tileColor: itemStyle.bgColor,
                            title: Text(
                              items[index].label,
                              style: itemStyle.labelStyle ??
                                  Theme.of(context).textTheme.titleMedium,
                            ),
                            trailing: items[index].hasChildren
                                ? itemStyle.trailingIcon
                                : null,
                            onTap: () {
                              onTapItem?.call(items[index], context);
                            },
                          ),
                  ),
                );
              },
            ),
    );
  }
}
