import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/breadcrumbs_path/breadcrumbs_path.dart';
import 'package:nested_choice_list/src/inherited_nested_list_view.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_style.dart';
import 'package:nested_choice_list/src/nested_list_view.dart';
import 'package:nested_choice_list/src/search_field/search_debouncer.dart';
import 'package:nested_choice_list/src/search_field/searchfield_position.dart';
import 'package:nested_choice_list/src/selected_item_chip_list/seleted_item_chip_list.dart';

typedef OnSelectionChange = void Function(List<NestedChoiceEntity> items);

class NestedChoiceList extends StatefulWidget {
  const NestedChoiceList({
    required this.items,
    this.selectedItems = const [],
    this.searchfieldPosition = SearchfieldPosition.bottom,
    this.showSelectedItems = true,
    this.enableSelectAll = true,
    this.selectAllLabel = 'Select all',
    this.showNavigationPath = false,
    this.isMultiSelect = false,
    this.enableSearch = false,
    this.searchDebouncer,
    this.style = const NestedListStyle(),
    this.onTapItem,
    this.itemLeadingBuilder,
    this.onSelectionChange,
    super.key,
  });

  final bool showSelectedItems;
  final String selectAllLabel;
  final bool enableSelectAll;
  final bool showNavigationPath;
  final bool isMultiSelect;
  final SearchfieldPosition searchfieldPosition;
  final List<NestedChoiceEntity> selectedItems;
  final List<NestedChoiceEntity> items;
  final bool enableSearch;
  final SearchDebouncer? searchDebouncer;
  final NestedListStyle style;
  final Function(NestedChoiceEntity)? onTapItem;
  final ItemLeadingBuilder? itemLeadingBuilder;
  final OnSelectionChange? onSelectionChange;

  @override
  State<NestedChoiceList> createState() => _NestedChoiceListState();
}

class _NestedChoiceListState extends State<NestedChoiceList> {
  final navigationPathes = <String>[];
  late final Set<NestedChoiceEntity> selectedItems =
      Set.from(widget.selectedItems);
  final _nestedNavKey = GlobalKey<NavigatorState>();

  void _onSelectAllCallback({
    required bool isSelected,
    required List<NestedChoiceEntity> items,
  }) {
    if (isSelected) {
      for (var i = 0; i < items.length; i++) {
        if (!items[i].hasChildren) {
          selectedItems.add(items[i]);
        }
      }
    } else {
      for (var i = 0; i < items.length; i++) {
        selectedItems.remove(items[i]);
      }
    }
    setState(() {});
    widget.onSelectionChange?.call(selectedItems.toList());
  }

  void _onPopInvokedWithResult(_, result) {
    navigationPathes.removeLast();
    setState(() {});
  }

  Future<void> _onNavigationPathTapped(index) async {
    if (index == navigationPathes.length - 1) return;
    final totalPathLength = navigationPathes.length;
    final popCount = totalPathLength - index - 1;
    for (var i = 0; i < popCount; i++) {
      await _nestedNavKey.currentState?.maybePop();
    }
  }

  void _onToggleSelection(NestedChoiceEntity item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    setState(() {});
    widget.onSelectionChange?.call(selectedItems.toList());
  }

  void _onTapItem(NestedChoiceEntity item, BuildContext ctx) {
    if (item.hasChildren) {
      navigationPathes.add(item.label);
      setState(() {});
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (context) {
            return InheritedNestedListView(
              selectedItems: selectedItems,
              child: NestedListView(
                items: item.children,
                searchfieldPosition: widget.searchfieldPosition,
                searchDebouncer: widget.searchDebouncer,
                enableSearch: widget.enableSearch,
                enableSelectAll: widget.enableSelectAll,
                selectAllLabel: widget.selectAllLabel,
                isMultiSelect: widget.isMultiSelect,
                itemLeadingBuilder: widget.itemLeadingBuilder,
                onTapItem: _onTapItem,
                searchfieldStyle: widget.style.searchfieldStyle,
                itemStyle: widget.style.itemStyle,
                selectAllItemStyle: widget.style.selectAllItemStyle,
                onToggleSelection: _onToggleSelection,
                onPopInvokedWithResult: _onPopInvokedWithResult,
                onSelectAllCallback: _onSelectAllCallback,
              ),
            );
          },
        ),
      );
    } else if (!widget.isMultiSelect) {
      widget.onTapItem?.call(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: navigationPathes.isEmpty,
      onPopInvokedWithResult: (didPop, result) {
        final nestedNavCanPop = _nestedNavKey.currentState?.canPop() ?? false;
        if (nestedNavCanPop) {
          _nestedNavKey.currentState?.maybePop();
        } else if (navigationPathes.isEmpty) {
          Navigator.maybePop(context);
        }
      },
      child: Material(
        color: widget.style.bgColor,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          onTap: () {
            if (FocusScope.of(context).hasFocus) {
              FocusScope.of(context).unfocus();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.showNavigationPath && navigationPathes.isNotEmpty)
                BreadcrumbsPath(
                  navigationPathItemStyle: widget.style.navigationPathItemStyle,
                  pathes: navigationPathes,
                  onTap: _onNavigationPathTapped,
                ),
              if (widget.isMultiSelect &&
                  widget.showSelectedItems &&
                  selectedItems.isNotEmpty)
                SeletedItemChipList(
                  selectedEntities: selectedItems,
                  onDeleted: (item) {
                    selectedItems.remove(item);
                    setState(() {});
                    widget.onSelectionChange?.call(selectedItems.toList());
                  },
                ),
              Expanded(
                child: Navigator(
                  key: _nestedNavKey,
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (_) => InheritedNestedListView(
                        selectedItems: selectedItems,
                        child: NestedListView(
                          items: widget.items,
                          searchfieldPosition: widget.searchfieldPosition,
                          enableSearch: widget.enableSearch,
                          searchDebouncer: widget.searchDebouncer,
                          enableSelectAll: widget.enableSelectAll,
                          isMultiSelect: widget.isMultiSelect,
                          selectAllLabel: widget.selectAllLabel,
                          searchfieldStyle: widget.style.searchfieldStyle,
                          itemStyle: widget.style.itemStyle,
                          selectAllItemStyle: widget.style.selectAllItemStyle,
                          onToggleSelection: _onToggleSelection,
                          onTapItem: _onTapItem,
                          onPopInvokedWithResult: _onPopInvokedWithResult,
                          itemLeadingBuilder: widget.itemLeadingBuilder,
                          onSelectAllCallback: _onSelectAllCallback,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
