import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/breadcrumbs_path/arrow_box_container.dart';
import 'package:nested_choice_list/src/nested_list_style/navigation_path_item_style.dart';

class BreadcrumbsPathItem extends StatelessWidget {
  const BreadcrumbsPathItem({
    required this.lable,
    this.navigationPathItemStyle = const NavigationPathItemStyle(),
    this.onTap,
    super.key,
  });

  final String lable;
  final VoidCallback? onTap;
  final NavigationPathItemStyle navigationPathItemStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: navigationPathItemStyle.margin,
      child: ArrowBoxContainer(
        onTap: onTap,
        color: navigationPathItemStyle.color,
        padding: navigationPathItemStyle.padding,
        child: Text(
          lable,
          textAlign: TextAlign.center,
          style: navigationPathItemStyle.labelStyle ??
              Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
