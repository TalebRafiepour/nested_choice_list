import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/inherited_nested_list_view.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_item_style.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_searchfield_style.dart';
import 'package:nested_choice_list/src/nested_list_view_item.dart';
import 'package:nested_choice_list/src/search_field/search_debouncer.dart';
import 'package:nested_choice_list/src/search_field/search_field.dart';

typedef ItemLeadingBuilder = Widget? Function(
  BuildContext context,
  NestedChoiceEntity item,
  int index,
);

typedef OnSelectAllCallback = void Function({
  required bool isSelected,
  required List<NestedChoiceEntity> items,
});

class NestedListView extends StatefulWidget {
  const NestedListView({
    required this.items,
    required this.onSelectAllCallback,
    this.selectAllLabel = 'Select all',
    this.searchfieldStyle = const NestedListSearchfieldStyle(),
    this.itemStyle = const NestedListItemStyle(),
    this.selectAllItemStyle = const NestedListItemStyle(),
    this.onPopInvokedWithResult,
    this.searchDebouncer,
    this.enableSearch = false,
    this.isMultiSelect = false,
    this.enableSelectAll = true,
    this.onTapItem,
    this.onToggleSelection,
    this.itemLeadingBuilder,
    super.key,
  });

  final bool enableSearch;
  final String selectAllLabel;
  final bool enableSelectAll;
  final bool isMultiSelect;
  final List<NestedChoiceEntity> items;
  final NestedListSearchfieldStyle searchfieldStyle;
  final SearchDebouncer? searchDebouncer;
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
  late final itemsToShow = List<NestedChoiceEntity>.from(widget.items);
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
      child: Column(
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
                  isSelected: isSelectedAll,
                  items: widget.items,
                );
              },
            ),
          Expanded(
            child: itemsToShow.isEmpty
                ? const Center(
                    child: Icon(
                      Icons.now_widgets_sharp,
                      color: Color.fromARGB(255, 169, 168, 168),
                      size: 48,
                    ),
                  )
                : ListView.builder(
                    itemCount: itemsToShow.length,
                    padding: widget.itemStyle.listPadding,
                    itemBuilder: (_, index) {
                      final item = itemsToShow[index];
                      return NestedListViewItem(
                        item: item,
                        itemStyle: widget.itemStyle,
                        isMultiSelect: widget.isMultiSelect,
                        isChecked: selectedItems.contains(item),
                        onTapItem: widget.onTapItem,
                        onToggleSelection: widget.onToggleSelection,
                        leading: widget.itemLeadingBuilder?.call(
                          context,
                          item,
                          index,
                        ),
                      );
                    },
                  ),
          ),
          if (widget.enableSearch)
            SearchField(
              inputDecoration: widget.searchfieldStyle.inputDecoration,
              searchDebouncer: widget.searchDebouncer,
              margin: widget.searchfieldStyle.margin,
              onSearch: (filter) {
                itemsToShow
                  ..clear()
                  ..addAll(
                    widget.items.where(
                      (element) => element.label.toLowerCase().contains(
                            filter.toLowerCase(),
                          ),
                    ),
                  );
                setState(() {});
              },
            ),
        ],
      ),
    );
  }
}
