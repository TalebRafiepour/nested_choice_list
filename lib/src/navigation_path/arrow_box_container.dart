import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/navigation_path/arrow_border_painter.dart';
import 'package:nested_choice_list/src/navigation_path/arrow_clipper.dart';

/// A widget that displays a container with an arrow shape and optional border.
///
/// The [ArrowBoxContainer] widget takes a child widget and displays it inside
/// a container with an arrow shape. The container can have a border and can
/// respond to tap events.
class ArrowBoxContainer extends StatelessWidget {
  /// Creates an [ArrowBoxContainer] widget.
  ///
  /// The [child] parameter must not be null.
  const ArrowBoxContainer({
    required this.child,
    this.padding = EdgeInsets.zero,
    this.onTap,
    this.color = const Color.fromARGB(255, 213, 208, 208),
    this.borderColor = Colors.white,
    this.borderWidth = 1,
    this.minHeight = 24,
    this.minWidth = 48,
    super.key,
  });

  /// The widget to be displayed inside the container.
  final Widget child;

  /// The background color of the container.
  final Color color;

  /// The padding inside the container.
  final EdgeInsets padding;

  /// Callback function to be called when the container is tapped.
  final VoidCallback? onTap;

  /// The minimum height of the container.
  final double minHeight;

  /// The minimum width of the container.
  final double minWidth;

  /// The width of the border.
  final double borderWidth;

  /// The color of the border.
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(borderWidth / 2),
      child: CustomPaint(
        painter: ArrowBorderPainter(
          borderColor: borderColor,
          borderWidth: borderWidth,
        ),
        child: ClipPath(
          clipper: const ArrowClipper(),
          child: GestureDetector(
            onTap: onTap,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: minHeight,
                minWidth: minWidth,
              ),
              child: Container(
                padding: EdgeInsets.only(
                  left: minHeight / 3 + padding.left,
                  top: padding.top,
                  right: minHeight / 3 + padding.right,
                  bottom: padding.bottom,
                ),
                alignment: Alignment.center,
                color: color,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
