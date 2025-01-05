import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/inherited_nested_list_view.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_item_style.dart';
import 'package:nested_choice_list/src/nested_list_view_item.dart';

typedef ItemLeadingBuilder = Widget? Function(
  BuildContext context,
  NestedChoiceEntity item,
  int index,
);

typedef OnSelectAllCallback = void Function(
  bool isSelected,
  List<NestedChoiceEntity> items,
);

class NestedListView extends StatefulWidget {
  const NestedListView({
    required this.items,
    required this.onSelectAllCallback,
    this.selectAllLabel = 'Select all',
    this.itemStyle = const NestedListItemStyle(),
    this.selectAllItemStyle = const NestedListItemStyle(),
    this.onPopInvokedWithResult,
    this.isMultiSelect = false,
    this.enableSelectAll = true,
    this.onTapItem,
    this.onToggleSelection,
    this.itemLeadingBuilder,
    super.key,
  });

  final String selectAllLabel;
  final bool enableSelectAll;
  final bool isMultiSelect;
  final List<NestedChoiceEntity> items;
  final NestedListItemStyle itemStyle;
  final NestedListItemStyle selectAllItemStyle;
  final Function(NestedChoiceEntity, BuildContext)? onTapItem;
  final Function(NestedChoiceEntity)? onToggleSelection;
  final PopInvokedWithResultCallback? onPopInvokedWithResult;
  final ItemLeadingBuilder? itemLeadingBuilder;
  final OnSelectAllCallback onSelectAllCallback;

  @override
  State<NestedListView> createState() => _NestedListViewState();
}

class _NestedListViewState extends State<NestedListView> {
  late bool isSelectedAll = false;
  late final bool hasAnySelectableChild;

  @override
  void initState() {
    hasAnySelectableChild = widget.items.any((e) => !e.hasChildren);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems =
        InheritedNestedListView.of(context)?.selectedItems ?? {};
    return PopScope(
      onPopInvokedWithResult: widget.onPopInvokedWithResult,
      child: widget.items.isEmpty
          ? const Center(
              child: Icon(
                Icons.now_widgets_sharp,
                color: Color.fromARGB(255, 169, 168, 168),
                size: 48,
              ),
            )
          : Column(
              children: [
                if (widget.enableSelectAll &&
                    widget.isMultiSelect &&
                    hasAnySelectableChild)
                  NestedListViewItem(
                    isMultiSelect: true,
                    isChecked: isSelectedAll,
                    itemStyle: widget.selectAllItemStyle,
                    item: NestedChoiceEntity(
                      value: 'value',
                      label: widget.selectAllLabel,
                    ),
                    onToggleSelection: (_) {
                      isSelectedAll = !isSelectedAll;
                      widget.onSelectAllCallback.call(
                        isSelectedAll,
                        widget.items,
                      );
                    },
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.items.length,
                    padding: widget.itemStyle.listPadding,
                    itemBuilder: (_, index) {
                      return NestedListViewItem(
                        item: widget.items[index],
                        itemStyle: widget.itemStyle,
                        isMultiSelect: widget.isMultiSelect,
                        isChecked: selectedItems.contains(widget.items[index]),
                        onTapItem: widget.onTapItem,
                        onToggleSelection: widget.onToggleSelection,
                        leading: widget.itemLeadingBuilder?.call(
                          context,
                          widget.items[index],
                          index,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
