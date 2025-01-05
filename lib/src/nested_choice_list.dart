import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/inherited_nested_list_view.dart';
import 'package:nested_choice_list/src/breadcrumbs_path/breadcrumbs_path.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_item_style.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_searchfield_style.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_style.dart';
import 'package:nested_choice_list/src/nested_list_view.dart';
import 'package:nested_choice_list/src/search_field/search_debouncer.dart';
import 'package:nested_choice_list/src/search_field/search_field.dart';
import 'package:nested_choice_list/src/selected_item_chip_list/seleted_item_chip_list.dart';

class NestedChoiceList extends StatefulWidget {
  const NestedChoiceList({
    required this.items,
    this.selectedItems = const [],
    this.showNavigationPath = false,
    this.isMultiSelect = false,
    this.enableSearch = false,
    this.searchDebouncer,
    this.style = const NestedListStyle(),
    this.searchfieldStyle = const NestedListSearchfieldStyle(),
    this.itemStyle = const NestedListItemStyle(),
    this.onTapItem,
    super.key,
  });

  final bool showNavigationPath;
  final bool isMultiSelect;
  final List<NestedChoiceEntity> selectedItems;
  final List<NestedChoiceEntity> items;
  final bool enableSearch;
  final SearchDebouncer? searchDebouncer;
  final NestedListStyle style;
  final NestedListSearchfieldStyle searchfieldStyle;
  final NestedListItemStyle itemStyle;
  final Function(NestedChoiceEntity)? onTapItem;

  @override
  State<NestedChoiceList> createState() => _NestedChoiceListState();
}

class _NestedChoiceListState extends State<NestedChoiceList> {
  final navigationPathes = <String>[];
  late final itemsToShow = List<NestedChoiceEntity>.from(widget.items);
  late final List<NestedChoiceEntity> selectedItems =
      List.from(widget.selectedItems);
  final _nestedNavKey = GlobalKey<NavigatorState>();

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
                itemStyle: widget.itemStyle,
                onToggleSelection: _onToggleSelection,
                onPopInvokedWithResult: _onPopInvokedWithResult,
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
                      builder: (_) => InheritedNestedListView(
                        selectedItems: selectedItems,
                        child: NestedListView(
                          items: itemsToShow,
                          isMultiSelect: widget.isMultiSelect,
                          itemStyle: widget.itemStyle,
                          onToggleSelection: _onToggleSelection,
                          onTapItem: _onTapItem,
                          onPopInvokedWithResult: _onPopInvokedWithResult,
                        ),
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
      ),
    );
  }
}
