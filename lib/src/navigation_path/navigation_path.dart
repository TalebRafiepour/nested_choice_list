import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/navigation_path/navigation_path_item.dart';
import 'package:nested_choice_list/src/nested_list_style/navigation_path_item_style.dart';

class NavigationPath extends StatelessWidget {
  const NavigationPath({
    required this.pathes,
    this.navigationPathItemStyle = const NavigationPathItemStyle(),
    this.onTap,
    super.key,
  });

  final List<String> pathes;
  final NavigationPathItemStyle navigationPathItemStyle;
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
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          pathes.length,
          (index) {
            return NavigationPathItem(
              navigationPathItemStyle: navigationPathItemStyle,
              lable: pathes[index],
              onTap: () {
                onTap?.call(index);
              },
            );
          },
        ),
      ),
    );
  }
}
