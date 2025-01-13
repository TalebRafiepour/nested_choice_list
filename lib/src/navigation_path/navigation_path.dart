import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/navigation_path/navigation_path_item.dart';
import 'package:nested_choice_list/src/nested_list_style/navigation_path_item_style.dart';

/// A widget that displays a horizontal navigation path.
///
/// The [NavigationPath] widget takes a list of path strings and displays them
/// as navigation items in a horizontal scrollable list.Each item can be tapped,
/// triggering the [onTap] callback.
class NavigationPath extends StatelessWidget {
  /// Creates a [NavigationPath] widget.
  ///
  /// The [pathes] parameter must not be null.
  const NavigationPath({
    required this.pathes,
    this.navigationPathItemStyle = const NavigationPathItemStyle(),
    this.onTap,
    super.key,
  });

  /// The list of path strings to be displayed.
  final List<String> pathes;

  /// The style to be applied to the navigation path items.
  final NavigationPathItemStyle navigationPathItemStyle;

  /// Callback function to be called when a navigation path item is tapped.
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
