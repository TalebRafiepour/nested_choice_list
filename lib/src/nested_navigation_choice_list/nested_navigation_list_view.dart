import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_choice_list.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_item_style.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_searchfield_style.dart';
import 'package:nested_choice_list/src/nested_navigation_choice_list/inherited_nested_navigation_list_view.dart';
import 'package:nested_choice_list/src/nested_navigation_choice_list/nested_navigation_list_view_item.dart';
import 'package:nested_choice_list/src/search_field/search_debouncer.dart';
import 'package:nested_choice_list/src/search_field/search_field.dart';
import 'package:nested_choice_list/src/search_field/searchfield_position.dart';

/// A widget that displays a nested list view with optional search and
/// multi-select functionality.
///
/// The [NestedNavigationListView] widget supports displaying a list of items
/// with optional search functionality, multi-selection, and select-all
/// functionality. It also allows customization of item styles and search
/// field styles.
class NestedNavigationListView extends StatefulWidget {
  /// Creates a [NestedNavigationListView] widget.
  ///
  /// The [items] and [onSelectAllCallback] parameters must not be null.
  const NestedNavigationListView({
    required this.items,
    this.onSelectAllCallback,
    this.selectAllLabel = 'Select all',
    this.searchfieldPosition = SearchfieldPosition.bottom,
    this.searchfieldStyle = const NestedListSearchfieldStyle(),
    this.itemStyle = const NestedListItemStyle(),
    this.selectAllItemStyle = const NestedListItemStyle(),
    this.onPopInvokedWithResult,
    this.searchDebouncer,
    this.enableSearch = false,
    this.enableMultiSelect = false,
    this.enableSelectAll = true,
    this.onTapItem,
    this.onToggleSelection,
    this.itemLeadingBuilder,
    super.key,
  });

  /// Whether to enable the search functionality.
  final bool enableSearch;

  /// The label for the select-all item.
  final String selectAllLabel;

  /// Whether to enable the select-all functionality.
  final bool enableSelectAll;

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

  /// The style to be applied to the select-all item.
  final NestedListItemStyle selectAllItemStyle;

  /// Callback function to be called when an item is tapped.
  final Function(NestedChoiceEntity, BuildContext)? onTapItem;

  /// Callback function to be called when an item's selection is toggled.
  final Function(NestedChoiceEntity)? onToggleSelection;

  /// Callback function to be called when the pop scope is invoked with result.
  final PopInvokedWithResultCallback? onPopInvokedWithResult;

  /// Builder function for the leading widget of each item.
  final ItemLeadingBuilder? itemLeadingBuilder;

  /// Callback function to be called when the select-all item is toggled.
  final OnSelectAllCallback? onSelectAllCallback;

  @override
  State<NestedNavigationListView> createState() =>
      _NestedNavigationListViewState();
}

class _NestedNavigationListViewState extends State<NestedNavigationListView> {
  /// A list of `NestedChoiceEntity` objects that are initialized
  /// from the `widget.items`.
  /// This list is used to store the items that will be displayed in
  /// the nested list view.
  late final itemsToShow = List<NestedChoiceEntity>.from(widget.items);

  /// A boolean flag indicating whether all items are selected.
  ///
  /// When `true`, it means all items in the list are selected.
  /// When `false`, it means not all items are selected.
  late bool isSelectedAll = false;

  /// Indicates whether any child in the nested list is selectable.
  ///
  /// This property is used to determine if there are any selectable
  /// items within the nested list view. It is initialized as a late
  /// final variable, meaning it must be set before it is accessed.
  late final bool hasAnySelectableChild;

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

  @override
  void initState() {
    hasAnySelectableChild = widget.items.any((e) => !e.hasChildren);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems =
        InheritedNestedNavigationListView.of(context)?.selectedItems ?? {};
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
            if (widget.enableSelectAll &&
                widget.enableMultiSelect &&
                hasAnySelectableChild)
              NestedNavigationListViewItem(
                isMultiSelect: true,
                isChecked: isSelectedAll,
                itemStyle: widget.selectAllItemStyle,
                item: NestedChoiceEntity(
                  value: 'value',
                  label: widget.selectAllLabel,
                ),
                onToggleSelection: (_) {
                  isSelectedAll = !isSelectedAll;
                  widget.onSelectAllCallback?.call(
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
                        return NestedNavigationListViewItem(
                          item: item,
                          itemStyle: widget.itemStyle,
                          isMultiSelect: widget.enableMultiSelect,
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
