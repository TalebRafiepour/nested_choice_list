import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/breadcrumbs_path/arrow_clipper.dart';

class ArrowBoxContainer extends StatelessWidget {
  const ArrowBoxContainer({
    required this.child,
    this.onTap,
    this.color = const Color.fromARGB(255, 213, 208, 208),
    super.key,
  });

  final Widget child;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraint) {
      return ClipPath(
        clipper: const ArrowClipper(),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: constraint.minHeight / 3),
            alignment: Alignment.center,
            color: color,
            child: child,
          ),
        ),
      );
    });
  }
}
