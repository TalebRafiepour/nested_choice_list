import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/breadcrumbs_path/arrow_box_container.dart';

class BreadcrumbsPathItem extends StatelessWidget {
  const BreadcrumbsPathItem({
    required this.lable,
    this.onTap,
    super.key,
  });

  final String lable;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ArrowBoxContainer(
      onTap: onTap,
      child: Text(
        lable,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
