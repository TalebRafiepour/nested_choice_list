import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/navigation_path/arrow_box_container.dart';

class NavigationPathItem extends StatelessWidget {
  const NavigationPathItem({
    required this.lable,
    super.key,
  });

  final String lable;

  @override
  Widget build(BuildContext context) {
    return ArrowBoxContainer(
      child: Text(
        lable,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
