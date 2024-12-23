import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_list_view.dart';
import 'package:nested_choice_list/src/nested_list_view_style.dart';

class NestedChoiceList extends StatelessWidget {
  const NestedChoiceList({
    required this.items,
    this.style = const NestedListViewStyle(),
    super.key,
  });

  final List<NestedChoiceEntity> items;
  final NestedListViewStyle style;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) {
              return NestedListView(
                items: items,
                style: style,
                onTapItem: (p0) {
                  Navigator.of(context).pop(p0);
                },
              );
            },
          );
        },
      ),
    );
  }
}
