import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';

/// An inherited widget that provides access to the selected items in a
/// nested list view.
///
/// The [InheritedNestedChoiceListView] widget allows descendant widgets to
/// access the set of selected items and listen for changes.
class InheritedNestedChoiceListView extends InheritedWidget {
  /// Creates an [InheritedNestedChoiceListView] widget.
  ///
  /// The [selectedItems] parameter must not be null.
  const InheritedNestedChoiceListView({
    required super.child,
    required this.selectedItems,
    super.key,
  });

  /// The set of selected items.
  final Set<NestedChoiceEntity> selectedItems;

  /// Retrieves the nearest [InheritedNestedChoiceListView] widget up the
  /// widget tree.
  ///
  /// This method allows descendant widgets to access the
  /// [InheritedNestedChoiceListView] and its selected items.
  static InheritedNestedChoiceListView? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedNestedChoiceListView>();
  }

  @override
  bool updateShouldNotify(
    covariant InheritedNestedChoiceListView oldWidget,
  ) {
    return selectedItems.length != oldWidget.selectedItems.length;
  }
}
