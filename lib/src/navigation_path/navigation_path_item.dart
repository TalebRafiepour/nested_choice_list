import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/navigation_path/arrow_box_container.dart';
import 'package:nested_choice_list/src/nested_list_style/navigation_path_item_style.dart';

/// A widget that displays a single navigation path item.
///
/// The [NavigationPathItem] widget takes a label and displays it inside an
/// [ArrowBoxContainer]. The item can be tapped,triggering the [onTap] callback.
class NavigationPathItem extends StatelessWidget {
  /// Creates a [NavigationPathItem] widget.
  ///
  /// The [lable] parameter must not be null.
  const NavigationPathItem({
    required this.lable,
    this.navigationPathItemStyle = const NavigationPathItemStyle(),
    this.onTap,
    super.key,
  });

  /// The label to be displayed inside the navigation path item.
  final String lable;

  /// Callback function to be called when the navigation path item is tapped.
  final VoidCallback? onTap;

  /// The style to be applied to the navigation path item.
  final NavigationPathItemStyle navigationPathItemStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: navigationPathItemStyle.margin,
      child: ArrowBoxContainer(
        onTap: onTap,
        color: navigationPathItemStyle.color,
        padding: navigationPathItemStyle.padding,
        borderColor: navigationPathItemStyle.borderColor,
        borderWidth: navigationPathItemStyle.borderWidth,
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
