import 'package:flutter/widgets.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_expansion_choice_list/expandable_choice_list_item.dart';

class NestedExpansionChoiceList extends StatelessWidget {
  const NestedExpansionChoiceList({
    required this.items,
    super.key,
  });

  final List<NestedChoiceEntity> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        if (item.hasChildren) {
          return ExpandableChoiceListItem(nestedChoiceEntity: item);
        } else {
          return Text(item.label);
        }
      },
    );
  }
}
