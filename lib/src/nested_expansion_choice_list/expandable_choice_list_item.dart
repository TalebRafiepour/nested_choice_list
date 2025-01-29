import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';

class ExpandableChoiceListItem extends StatelessWidget {
  const ExpandableChoiceListItem({
    required this.nestedChoiceEntity,
    super.key,
  });

  final NestedChoiceEntity nestedChoiceEntity;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(nestedChoiceEntity.label),
      children: nestedChoiceEntity.children.map(
        (item) {
          if (item.hasChildren) {
            return ExpandableChoiceListItem(nestedChoiceEntity: item);
          } else {
            return Text(item.label);
          }
        },
      ).toList(),
    );
  }
}
