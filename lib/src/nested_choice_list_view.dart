import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/inherited_nested_choice_list_view.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_choice_list.dart';
import 'package:nested_choice_list/src/nested_choice_list_item.dart';
import 'package:nested_choice_list/src/nested_choice_list_type.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_item_style.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_searchfield_style.dart';
import 'package:nested_choice_list/src/search_field/search_debouncer.dart';
import 'package:nested_choice_list/src/search_field/search_field.dart';
import 'package:nested_choice_list/src/search_field/searchfield_position.dart';

/// A widget that displays a nested list view with optional search and
/// multi-select functionality.
///
/// The [NestedChoiceListView] widget supports displaying a list of items
/// with optional search functionality, multi-selection, and select-all
/// functionality. It also allows customization of item styles and search
/// field styles.
class NestedChoiceListView extends StatefulWidget {
  /// Creates a [NestedChoiceListView] widget.
  ///
  /// The [items] and [onSelectAllCallback] parameters must not be null.
  const NestedChoiceListView({
    required this.items,
    this.type = NestedChoiceListType.navigation,
    this.onSelectAllCallback,
    this.searchfieldPosition = SearchfieldPosition.bottom,
    this.searchfieldStyle = const NestedListSearchfieldStyle(),
    this.itemStyle = const NestedListItemStyle(),
    this.onPopInvokedWithResult,
    this.searchDebouncer,
    this.enableSearch = false,
    this.enableMultiSelect = false,
    this.onTapItem,
    this.onToggleSelection,
    this.itemLeadingBuilder,
    this.onExpansionChanged,
    super.key,
  });

  /// Callback function that is triggered when the expansion state changes.
  final OnExpansionChanged? onExpansionChanged;

  /// The type of the nested choice list.
  final NestedChoiceListType type;

  /// Whether to enable the search functionality.
  final bool enableSearch;

  /// Whether to enable multi-selection.
  final bool enableMultiSelect;

  /// The list of items to be displayed.
  final List<NestedChoiceEntity> items;

  /// The position of the search field (top or bottom).
  final SearchfieldPosition searchfieldPosition;

  /// The style to be applied to the search field.
  final NestedListSearchfieldStyle searchfieldStyle;

  /// The debouncer for the search field.
  final SearchDebouncer? searchDebouncer;

  /// The style to be applied to the list items.
  final NestedListItemStyle itemStyle;

  /// Callback function to be called when an item is tapped.
  final Function(NestedChoiceEntity, BuildContext)? onTapItem;

  /// Callback function to be called when an item's selection is toggled.
  final OnToggleSelection? onToggleSelection;

  /// Callback function to be called when the pop scope is invoked with result.
  final PopInvokedWithResultCallback? onPopInvokedWithResult;

  /// Builder function for the leading widget of each item.
  final ItemLeadingBuilder? itemLeadingBuilder;

  /// Callback function to be called when the select-all item is toggled.
  final OnSelectAllCallback? onSelectAllCallback;

  @override
  State<NestedChoiceListView> createState() => _NestedChoiceListViewState();
}

class _NestedChoiceListViewState extends State<NestedChoiceListView> {
  /// A list of `NestedChoiceEntity` objects that are initialized
  /// from the `widget.items`.
  /// This list is used to store the items that will be displayed in
  /// the nested list view.
  late final itemsToShow = List<NestedChoiceEntity>.from(widget.items);

  /// Filters the items based on the search query.
  void _onSearch(String filter) {
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
  }

  /// Checks if a given `NestedChoiceEntity` item is selected.
  ///
  /// If the item has children, it returns true if all children are in the
  /// `selectedItems` set. Otherwise, it returns true if the item itself is
  /// in the `selectedItems` set.
  ///
  /// - Parameters:
  ///   - item: The `NestedChoiceEntity` item to check.
  ///   - selectedItems: A set of selected `NestedChoiceEntity` items.
  ///
  /// - Returns: A boolean indicating whether the item (and its children,if any)
  ///   are selected.
  bool _isChecked(
    NestedChoiceEntity item,
    Set<NestedChoiceEntity> selectedItems,
  ) {
    if (item.hasChildren) {
      return item.leafChildren.every((e) => selectedItems.contains(e));
    } else {
      return selectedItems.contains(item);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems =
        InheritedNestedChoiceListView.of(context)?.selectedItems ?? {};
    return PopScope(
      onPopInvokedWithResult: widget.onPopInvokedWithResult,
      child: SafeArea(
        child: Column(
          children: [
            if (widget.enableSearch &&
                widget.searchfieldPosition == SearchfieldPosition.top)
              SearchField(
                searchfieldStyle: widget.searchfieldStyle,
                searchDebouncer: widget.searchDebouncer,
                onSearch: _onSearch,
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
                        return NestedChoiceListItem(
                          item: item,
                          isExpandable:
                              widget.type == NestedChoiceListType.expandable,
                          itemStyle: widget.itemStyle,
                          enableMultiSelect: widget.enableMultiSelect,
                          isChecked: (currentItem) {
                            return _isChecked(currentItem, selectedItems);
                          },
                          onTapItem: widget.onTapItem,
                          onToggleSelection: widget.onToggleSelection,
                          itemLeadingBuilder: widget.itemLeadingBuilder,
                          onExpansionChanged: widget.onExpansionChanged,
                        );
                      },
                    ),
            ),
            if (widget.enableSearch &&
                widget.searchfieldPosition == SearchfieldPosition.bottom)
              SearchField(
                searchfieldStyle: widget.searchfieldStyle,
                searchDebouncer: widget.searchDebouncer,
                onSearch: _onSearch,
              ),
          ],
        ),
      ),
    );
  }
}
