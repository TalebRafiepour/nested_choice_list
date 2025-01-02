import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/breadcrumbs_path/breadcrumbs_path_item.dart';

class BreadcrumbsPath extends StatelessWidget {
  const BreadcrumbsPath({
    required this.pathes,
    this.onTap,
    super.key,
  });

  final List<String> pathes;
  final Function(int index)? onTap;
  

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    scheduleMicrotask(() {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: pathes.length,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return BreadcrumbsPathItem(
            lable: pathes[index],
            onTap: () {
              onTap?.call(index);
            },
          );
        },
      ),
    );
  }
}
