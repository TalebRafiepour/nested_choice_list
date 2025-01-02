import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/inherited_nested_list_view.dart';
import 'package:nested_choice_list/src/breadcrumbs_path/breadcrumbs_path.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_list_view.dart';
import 'package:nested_choice_list/src/nested_list_view_style.dart';
import 'package:nested_choice_list/src/search_field/search_debouncer.dart';
import 'package:nested_choice_list/src/search_field/search_field.dart';
import 'package:nested_choice_list/src/selected_item_chip_list/seleted_item_chip_list.dart';

class NestedChoiceList extends StatefulWidget {
  const NestedChoiceList({
    required this.items,
    this.showNavigationPath = false,
    this.isMultiSelect = false,
    this.enableSearch = false,
    this.searchDebouncer,
    this.style = const NestedListViewStyle(),
    this.onTapItem,
    super.key,
  });

  final bool showNavigationPath;
  final bool isMultiSelect;
  final List<NestedChoiceEntity> items;
  final bool enableSearch;
  final SearchDebouncer? searchDebouncer;
  final NestedListViewStyle style;
  final Function(NestedChoiceEntity)? onTapItem;

  @override
  State<NestedChoiceList> createState() => _NestedChoiceListState();
}

class _NestedChoiceListState extends State<NestedChoiceList> {
  final navigationPathes = <String>[];
  late final itemsToShow = List<NestedChoiceEntity>.from(widget.items);
  final List<NestedChoiceEntity> selectedItems = [];
  final _nestedNavKey = GlobalKey<NavigatorState>();

  void _onNavigationPathTapped(index) {
    if (index == navigationPathes.length - 1) return;
    final totalPathLength = navigationPathes.length;
    navigationPathes.removeRange(
      index + 1,
      navigationPathes.length,
    );
    final popCount = totalPathLength - index - 1;
    for (var i = 0; i < popCount; i++) {
      _nestedNavKey.currentState?.maybePop();
    }
    setState(() {});
  }

  void _onToggleSelection(NestedChoiceEntity item) {
    widget.onTapItem?.call(item);
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    setState(() {});
  }

  void _onTapItem(item, BuildContext ctx) {
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
                isMultiSelect: widget.isMultiSelect,
                onTapItem: _onTapItem,
                style: widget.style,
                onToggleSelection: _onToggleSelection,
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
    return Material(
      child: InkWell(
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
                pathes: navigationPathes,
                onTap: _onNavigationPathTapped,
              ),
            if (widget.isMultiSelect && selectedItems.isNotEmpty)
              SeletedItemChipList(
                selectedEntities: selectedItems,
                onDeleted: (item) {
                  selectedItems.remove(item);
                  widget.onTapItem?.call(item);
                  setState(() {});
                },
              ),
            Expanded(
              child: Navigator(
                key: _nestedNavKey,
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (ctx) {
                      return InheritedNestedListView(
                        selectedItems: selectedItems,
                        child: NestedListView(
                          items: itemsToShow,
                          isMultiSelect: widget.isMultiSelect,
                          style: widget.style,
                          onToggleSelection: _onToggleSelection,
                          onTapItem: _onTapItem,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            if (widget.enableSearch)
              SearchField(
                inputDecoration: widget.style.searchInputDecoration,
                searchDebouncer: widget.searchDebouncer,
                margin: widget.style.searchFieldMargin,
                onSearch: (filter) {
                  itemsToShow.clear();
                  itemsToShow.addAll(
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
      ),
    );
  }
}
