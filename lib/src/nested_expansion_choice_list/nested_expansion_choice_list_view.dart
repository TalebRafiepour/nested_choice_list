import 'package:flutter/material.dart';
import 'package:nested_choice_list/nested_choice_list.dart';
import 'package:nested_choice_list/src/nested_expansion_choice_list/nested_expansion_choice_list_item.dart';

class NestedExpansionChoiceListView extends StatelessWidget {
  const NestedExpansionChoiceListView({
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
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return NestedExpansionChoiceListItem(
          item: item,
          itemStyle: itemStyle,
          itemLeadingBuilder: itemLeadingBuilder,
          isChecked: (currentItem) {
            return false; // check if the currentItem exist in selected list
          },
          enableMultiSelect: enableMultiSelect,
          onTapItem: onTapItem,
          onToggleSelection: onToggleSelection,
        );
      },
    );
  }
}
