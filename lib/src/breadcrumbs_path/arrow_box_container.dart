import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/breadcrumbs_path/arrow_border_painter.dart';
import 'package:nested_choice_list/src/breadcrumbs_path/arrow_clipper.dart';

class ArrowBoxContainer extends StatelessWidget {
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

  final Widget child;
  final Color color;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final double minHeight;
  final double minWidth;
  //
  final double borderWidth;
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
