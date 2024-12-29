import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_list_view_style.dart';

class NestedListView extends StatefulWidget {
  const NestedListView({
    required this.items,
    required this.style,
    this.selectedItems = const [],
    this.isMultiSelect = false,
    this.onTapItem,
    this.onToggleSelection,
    super.key,
  });

  final bool isMultiSelect;
  final List<NestedChoiceEntity> items;
  final NestedListViewStyle style;
  final Function(NestedChoiceEntity)? onTapItem;
  final Function(NestedChoiceEntity)? onToggleSelection;
  final List<NestedChoiceEntity> selectedItems;

  @override
  State<NestedListView> createState() => _NestedListViewState();
}

class _NestedListViewState extends State<NestedListView> {
  late List<NestedChoiceEntity> selectedItems = List.from(widget.selectedItems);
  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const Center(
        child: Icon(
          Icons.now_widgets_sharp,
          color: Color.fromARGB(255, 169, 168, 168),
          size: 48,
        ),
      );
    } else {
      return ListView.builder(
        itemCount: widget.items.length,
        padding: widget.style.listPadding,
        itemBuilder: (_, index) {
          return Padding(
            padding: widget.style.itemMargin,
            child: Material(
              child: widget.isMultiSelect && !widget.items[index].hasChildren
                  ? CheckboxListTile(
                      value: selectedItems.contains(widget.items[index]),
                      onChanged: (isSelected) {
                        widget.onToggleSelection?.call(widget.items[index]);
                        if (isSelected ?? false) {
                          selectedItems.add(widget.items[index]);
                        } else {
                          selectedItems.remove(widget.items[index]);
                        }
                        setState(() {});
                      },
                      shape: widget.style.itemShape,
                      enabled: !widget.items[index].isDisabled,
                      title: Text(
                        widget.items[index].label,
                        style: widget.style.labelStyle ??
                            Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  : ListTile(
                      shape: widget.style.itemShape,
                      enabled: !widget.items[index].isDisabled,
                      title: Text(
                        widget.items[index].label,
                        style: widget.style.labelStyle ??
                            Theme.of(context).textTheme.titleMedium,
                      ),
                      trailing: widget.items[index].hasChildren
                          ? widget.style.trailingIcon
                          : null,
                      onTap: () {
                        widget.onTapItem?.call(widget.items[index]);
                      },
                    ),
            ),
          );
        },
      );
    }
  }
}
