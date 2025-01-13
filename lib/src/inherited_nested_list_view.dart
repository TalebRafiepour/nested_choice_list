import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';

/// An inherited widget that provides access to the selected items in a 
/// nested list view.
/// 
/// The [InheritedNestedListView] widget allows descendant widgets to access
/// the set of selected items and listen for changes.
class InheritedNestedListView extends InheritedWidget {
  /// Creates an [InheritedNestedListView] widget.
  /// 
  /// The [selectedItems] parameter must not be null.
  const InheritedNestedListView({
    required super.child,
    required this.selectedItems,
    super.key,
  });

  /// The set of selected items.
  final Set<NestedChoiceEntity> selectedItems;

  /// Retrieves the nearest [InheritedNestedListView] widget up the widget tree.
  /// 
  /// This method allows descendant widgets to access the 
  /// [InheritedNestedListView] and its selected items.
  static InheritedNestedListView? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedNestedListView>();
  }

  @override
  bool updateShouldNotify(covariant InheritedNestedListView oldWidget) {
    return selectedItems.length != oldWidget.selectedItems.length;
  }
}
