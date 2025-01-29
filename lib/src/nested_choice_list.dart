import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_choice_list_type.dart';
import 'package:nested_choice_list/src/nested_expansion_choice_list/nested_expansion_choice_list.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_style.dart';
import 'package:nested_choice_list/src/nested_navigation_choice_list/nested_navigation_choice_list.dart';
import 'package:nested_choice_list/src/search_field/search_debouncer.dart';
import 'package:nested_choice_list/src/search_field/searchfield_position.dart';

/// A typedef for a function that builds a leading widget for an item in
/// a nested list view.
///
/// The function takes the following parameters:
/// - `context`: The build context in which the widget is built.
/// - `item`: The `NestedChoiceEntity` item for which the leading widget is
/// being built.
///
/// Returns a `Widget?` that represents the leading widget for the given item.
typedef ItemLeadingBuilder = Widget? Function(
  BuildContext context,
  NestedChoiceEntity item,
);

/// A callback function that is triggered when the "select all" action
/// is performed.
///
/// The [isSelected] parameter indicates whether all items are selected or not.
/// The [items] parameter provides the list of [NestedChoiceEntity] items that
/// are affected by the selection.
typedef OnSelectAllCallback = void Function({
  required bool isSelected,
  required List<NestedChoiceEntity> items,
});

/// A typedef for a callback function that is triggered when the
/// navigation changes.
///
/// The function takes an integer parameter [pageIndex] which represents the
/// index of the page that is being navigated to.
typedef OnNavigationChange = void Function(int pageIndex);

/// A typedef for a callback function that is triggered when the selection
/// changes. This callback triggered when you are in multi
/// selection mode (enableMultiSelect = true).
///
/// The [OnSelectionChange] function is called with a list of
///  [NestedChoiceEntity] items
/// whenever the selection changes. This allows you to handle the updated
/// selection in your application.
///
/// Example usage:
/// ```dart
/// void handleSelectionChange(List<NestedChoiceEntity> items) {
///   // Handle the updated selection
/// }
///
/// OnSelectionChange onSelectionChange = handleSelectionChange;
/// ```
///
/// The [items] parameter contains the list of selected
///  [NestedChoiceEntity] items.
typedef OnSelectionChange = void Function(List<NestedChoiceEntity> items);

/// A typedef for a callback function that is triggered when an item is tapped.
/// This callback triggered when you are in single
/// selection mode (enableMultiSelect = false).
///
/// The [NestedListItemTap] function is called with a [NestedChoiceEntity] item
/// whenever an item is tapped. This allows you to handle the item tap event
/// in your application.
///
/// Example usage:
/// ```dart
/// void handleItemTap(NestedChoiceEntity item) {
///   // Handle the item tap event
/// }
///
/// NestedListItemTap onTapItem = handleItemTap;
/// ```
///
/// The [item] parameter contains the tapped [NestedChoiceEntity] item.
typedef NestedListItemTap = void Function(NestedChoiceEntity item);

/// A [StatefulWidget] that represents a nested choice list.
///
/// This widget allows users to select choices from a nested list structure.
/// It maintains its own state and updates the UI based on user interactions.
///
/// Example usage:
///
/// ```dart
/// NestedChoiceList(
///   // Add necessary parameters here
/// )
/// ```
///
/// The [NestedChoiceList] widget can be customized by providing various
/// parameters to control its appearance and behavior.
class NestedChoiceList extends StatelessWidget {
  const NestedChoiceList({
    required this.items,
    this.selectedItems = const [],
    this.searchfieldPosition = SearchfieldPosition.bottom,
    this.showSelectedItems = true,
    this.enableSelectAll = true,
    this.selectAllLabel = 'Select all',
    this.showNavigationPath = false,
    this.enableMultiSelect = false,
    this.enableSearch = false,
    this.searchDebouncer,
    this.style = const NestedListStyle(),
    this.onTapItem,
    this.itemLeadingBuilder,
    this.onSelectionChange,
    this.onNavigationChange,
    super.key,
  }) : type = NestedChoiceListType.navigation;

  const NestedChoiceList.expandable({
    required this.items,
    this.selectedItems = const [],
    this.searchfieldPosition = SearchfieldPosition.bottom,
    this.showSelectedItems = true,
    this.enableSelectAll = true,
    this.selectAllLabel = 'Select all',
    this.showNavigationPath = false,
    this.enableMultiSelect = false,
    this.enableSearch = false,
    this.searchDebouncer,
    this.style = const NestedListStyle(),
    this.onTapItem,
    this.itemLeadingBuilder,
    this.onSelectionChange,
    this.onNavigationChange,
    super.key,
  }) : type = NestedChoiceListType.expandable;

  /// The type of the nested choice list.
  final NestedChoiceListType type;

  /// Whether to show the selected items.
  final bool showSelectedItems;

  /// The label for the "Select all" option.
  final String selectAllLabel;

  /// Whether to enable the "Select all" option.
  final bool enableSelectAll;

  /// Whether to show the navigation path.
  final bool showNavigationPath;

  /// Whether to enable multi-selection mode.
  final bool enableMultiSelect;

  /// The position of the search field.
  final SearchfieldPosition searchfieldPosition;

  /// The list of initially selected items.
  final List<NestedChoiceEntity> selectedItems;

  /// The list of items to display in the nested choice list.
  final List<NestedChoiceEntity> items;

  /// Whether to enable the search functionality.
  final bool enableSearch;

  /// The debouncer for the search field.
  final SearchDebouncer? searchDebouncer;

  /// The style for the nested list.
  final NestedListStyle style;

  /// The callback function to handle item tap events.
  final NestedListItemTap? onTapItem;

  /// The builder for the leading widget of each item.
  final ItemLeadingBuilder? itemLeadingBuilder;

  /// The callback function to handle selection change events.
  final OnSelectionChange? onSelectionChange;

  /// Callback function triggered on navigation changes.
  final OnNavigationChange? onNavigationChange;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      NestedChoiceListType.navigation => NestedNavigationChoiceList(
          items: items,
          selectedItems: selectedItems,
          searchfieldPosition: searchfieldPosition,
          showSelectedItems: showSelectedItems,
          enableSelectAll: enableSelectAll,
          enableMultiSelect: enableMultiSelect,
          enableSearch: enableSearch,
          selectAllLabel: selectAllLabel,
          searchDebouncer: searchDebouncer,
          showNavigationPath: showNavigationPath,
          style: style,
          onSelectionChange: onSelectionChange,
          onNavigationChange: onNavigationChange,
          onTapItem: onTapItem,
        ),
      NestedChoiceListType.expandable =>
        NestedExpansionChoiceList(items: items),
    };
  }
}
