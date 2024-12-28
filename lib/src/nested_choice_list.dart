import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_list_view.dart';
import 'package:nested_choice_list/src/nested_list_view_style.dart';
import 'package:nested_choice_list/src/search_debouncer.dart';
import 'package:nested_choice_list/src/search_field.dart';

class NestedChoiceList extends StatefulWidget {
  const NestedChoiceList({
    required this.items,
    this.enableSearch = true,
    this.searchDebouncer,
    this.style = const NestedListViewStyle(),
    this.onTapItem,
    super.key,
  });

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
              builder: (_) {
                return NestedListView(
                  items: itemsToShow,
                  style: widget.style,
                  onTapItem: widget.onTapItem,
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
