import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';

/// An inherited widget that provides access to the selected items in a
/// nested list view.
///
/// The [InheritedNestedNavigationListView] widget allows descendant widgets to
/// access the set of selected items and listen for changes.
class InheritedNestedNavigationListView extends InheritedWidget {
  /// Creates an [InheritedNestedNavigationListView] widget.
  ///
  /// The [selectedItems] parameter must not be null.
  const InheritedNestedNavigationListView({
    required super.child,
    required this.selectedItems,
    super.key,
  });

  /// The set of selected items.
  final Set<NestedChoiceEntity> selectedItems;

  /// Retrieves the nearest [InheritedNestedNavigationListView] widget up the
  /// widget tree.
  ///
  /// This method allows descendant widgets to access the
  /// [InheritedNestedNavigationListView] and its selected items.
  static InheritedNestedNavigationListView? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        InheritedNestedNavigationListView>();
  }

  @override
  bool updateShouldNotify(
    covariant InheritedNestedNavigationListView oldWidget,
  ) {
    return selectedItems.length != oldWidget.selectedItems.length;
  }
}
