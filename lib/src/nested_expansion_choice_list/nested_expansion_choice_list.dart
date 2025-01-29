import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_expansion_choice_list/nested_expansion_choice_list_view.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_style.dart';

class NestedExpansionChoiceList extends StatelessWidget {
  const NestedExpansionChoiceList({
    required this.items,
    this.style = const NestedListStyle(),
    super.key,
  });

  final List<NestedChoiceEntity> items;
  final NestedListStyle style;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: style.bgColor,
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
        child: NestedExpansionChoiceListView(items: items),
      ),
    );
  }
}
