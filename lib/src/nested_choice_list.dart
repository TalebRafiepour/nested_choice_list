import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_list_view.dart';
import 'package:nested_choice_list/src/nested_list_view_style.dart';
import 'package:nested_choice_list/src/search_debouncer.dart';
import 'package:nested_choice_list/src/search_field.dart';

class NestedChoiceList extends StatefulWidget {
  const NestedChoiceList({
    required this.items,
    this.isMultiSelect = false,
    this.enableSearch = true,
    this.searchDebouncer,
    this.style = const NestedListViewStyle(),
    this.onTapItem,
    super.key,
  });

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
  late final itemsToShow = List<NestedChoiceEntity>.from(widget.items);
  final List<NestedChoiceEntity> selectedItems = [];

  void _onToggleSelection(NestedChoiceEntity item) {
    widget.onTapItem?.call(item);
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
  }

  void _onTapItem(item, BuildContext ctx) {
    if (item.hasChildren) {
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (context) => NestedListView(
            items: item.children,
            isMultiSelect: widget.isMultiSelect,
            selectedItems: selectedItems,
            onTapItem: (item) => _onTapItem(item, context),
            style: widget.style,
            onToggleSelection: _onToggleSelection,
          ),
        ),
      );
    } else {
      // todo
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Navigator(
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (ctx) {
                return NestedListView(
                  items: itemsToShow,
                  isMultiSelect: widget.isMultiSelect,
                  style: widget.style,
                  selectedItems: selectedItems,
                  onToggleSelection: _onToggleSelection,
                  onTapItem: (item) => _onTapItem(item, ctx),
                );
              },
            );
          },
        ),
        bottomNavigationBar: widget.enableSearch
            ? SearchField(
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
              )
            : null,
      ),
    );
  }
}
