import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/inherited_nested_list_view.dart';
import 'package:nested_choice_list/src/navigation_path/navigation_path.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_style.dart';
import 'package:nested_choice_list/src/nested_list_view.dart';
import 'package:nested_choice_list/src/search_field/search_debouncer.dart';
import 'package:nested_choice_list/src/search_field/searchfield_position.dart';
import 'package:nested_choice_list/src/selected_item_chip_list/seleted_item_chip_list.dart';

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
class NestedChoiceList extends StatefulWidget {
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
  });

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
  State<NestedChoiceList> createState() => _NestedChoiceListState();
}

class _NestedChoiceListState extends State<NestedChoiceList> {
  /// The list of navigation paths.
  final navigationPathes = <String>[];

  /// The set of selected items.
  late final Set<NestedChoiceEntity> selectedItems =
      Set.from(widget.selectedItems);

  /// The key for the nested navigator.
  final _nestedNavKey = GlobalKey<NavigatorState>();

  /// Callback function for the "Select all" option.
  ///
  /// [isSelected] indicates whether the items are selected.
  /// [items] is the list of items to be selected or deselected.
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

  /// Callback function invoked when a pop action is performed.
  ///
  /// [result] is the result of the pop action.
  void _onPopInvokedWithResult(_, result) {
    navigationPathes.removeLast();
    setState(() {});
    //
    widget.onNavigationChange?.call(navigationPathes.length);
  }

  /// Callback function for tapping on a navigation path.
  ///
  /// [index] is the index of the tapped navigation path.
  Future<void> _onNavigationPathTapped(index) async {
    if (index == navigationPathes.length - 1) return;
    final totalPathLength = navigationPathes.length;
    final popCount = totalPathLength - index - 1;
    for (var i = 0; i < popCount; i++) {
      await _nestedNavKey.currentState?.maybePop();
    }
  }

  /// Toggles the selection of an item.
  ///
  /// [item] is the item to be toggled.
  void _onToggleSelection(NestedChoiceEntity item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    setState(() {});
    widget.onSelectionChange?.call(selectedItems.toList());
  }

  /// Handles the tap event on an item.
  /// If the item has children, it navigates to a new nested list view.
  /// If the item does not have children and multi-selection is disabled,
  /// it triggers the [_onTapItem] callback.
  /// If the item does not have children and multi-selection is enabled,
  /// it triggers the [_onToggleSelection] callback.
  ///
  /// [item] is the tapped item.
  /// [ctx] is the build context.
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
                enableMultiSelect: widget.enableMultiSelect,
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
      //
      widget.onNavigationChange?.call(navigationPathes.length);
      //
    } else if (!widget.enableMultiSelect) {
      widget.onTapItem?.call(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Handles the pop scope for the inner navigation.
    ///
    /// This function is used to determine whether the current navigation stack
    /// can be popped. If the nested navigation can pop, it will pop the nested
    /// navigation. If the main navigation path is empty, it will attempt to pop
    /// the main navigation context.
    ///
    /// - `canPop`: A boolean indicating if the navigation path is empty.
    /// - `onPopInvokedWithResult`: A callback function that is invoked when a
    ///   pop action is requested. It takes two parameters:
    ///   - `didPop`: A boolean indicating if the pop action was successful.
    ///   - `result`: The result of the pop action.
    return PopScope(
      canPop: navigationPathes.isEmpty,
      onPopInvokedWithResult: (didPop, result) {
        /// If the widget did pop, return immediately without handling
        /// inner navigation.
        /// This ensures that when the whole widget is popped, inner
        /// navigation is not processed.
        if (didPop) {
          return;
        }
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
            /// If the current focus scope has focus, this code will unfocus it.
            /// This is useful for dismissing the keyboard or any other
            /// focus-related widgets.
            if (FocusScope.of(context).hasFocus) {
              FocusScope.of(context).unfocus();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Displays the navigation path if `showNavigationPath` is true
              /// and `navigationPathes` is not empty.
              ///
              /// The `NavigationPath` widget is used to show the current
              /// navigation path with the specified style and
              /// handles tap events using the
              ///  `_onNavigationPathTapped` callback.
              ///
              /// - `widget.showNavigationPath`: A boolean that determines
              /// whether to show the navigation path.
              /// - `navigationPathes`: A list of navigation paths
              /// to be displayed.
              /// - `widget.style.navigationPathItemStyle`: The style to
              /// be applied to each navigation path item.
              /// - `_onNavigationPathTapped`: The callback function to handle
              ///  tap events on the navigation path.
              if (widget.showNavigationPath && navigationPathes.isNotEmpty)
                NavigationPath(
                  navigationPathItemStyle: widget.style.navigationPathItemStyle,
                  pathes: navigationPathes,
                  onTap: _onNavigationPathTapped,
                ),

              /// Displays a list of selected items as chips if multi-select is
              /// enabled, selected items should be shown, and there are
              /// selected items.
              ///
              /// The `SeletedItemChipList` widget is used to display
              /// the selected items.
              /// When an item chip is deleted, it is removed from
              /// the `selectedItems` list,
              /// the state is updated, and the `onSelectionChange` callback
              /// is called with the updated list of selected items.
              ///
              /// - `widget.enableMultiSelect`: A boolean indicating
              /// if multi-select is enabled.
              /// - `widget.showSelectedItems`: A boolean indicating
              /// if selected items should be shown.
              /// - `selectedItems`: A list of selected items.
              /// - `widget.onSelectionChange`: A callback function that is
              /// called when the selection changes.
              if (widget.enableMultiSelect &&
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
                /// Just used independent `Navigator` widget for handling
                /// inner navigation of the `NestedChoiceList` widget
                /// independent of whole application navigation.
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
                          enableMultiSelect: widget.enableMultiSelect,
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
