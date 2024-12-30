import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';

class InheritedNestedListView extends InheritedWidget {
  const InheritedNestedListView({
    super.key,
    required super.child,
    required this.selectedItems,
  });

  final List<NestedChoiceEntity> selectedItems;

  static InheritedNestedListView? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedNestedListView>();
  }

  @override
  bool updateShouldNotify(covariant InheritedNestedListView oldWidget) {
    return selectedItems.length != oldWidget.selectedItems.length;
  }
}
