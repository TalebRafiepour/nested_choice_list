import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/navigation_path/navigation_path_item.dart';

class NavigationPath extends StatelessWidget {
  const NavigationPath({
    required this.pathes,
    super.key,
  });

  final List<String> pathes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pathes.length,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return NavigationPathItem(lable: pathes[index]);
        },
      ),
    );
  }
}
