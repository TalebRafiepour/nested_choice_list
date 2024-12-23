import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';
import 'package:nested_choice_list/src/nested_list_view_style.dart';

class NestedListView extends StatelessWidget {
  const NestedListView({
    required this.items,
    required this.style,
    this.onTapItem,
    super.key,
  });

  final List<NestedChoiceEntity> items;
  final NestedListViewStyle style;
  final Function(int)? onTapItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      padding: style.listPadding,
      itemBuilder: (_, index) {
        return Padding(
          padding: style.itemMargin ?? const EdgeInsets.all(4),
          child: Material(
            child: ListTile(
              shape: style.itemShape,
              enabled: !items[index].isDisabled,
              title: Text(
                items[index].label,
                style: style.labelStyle ?? Theme.of(context).textTheme.titleMedium,
              ),
              trailing: items[index].hasChildren
                  ? style.trailingIcon
                  : null,
              onTap: () async {
                if (items[index].hasChildren) {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => NestedListView(
                        items: items[index].children,
                        onTapItem: onTapItem,
                        style: style,
                      ),
                    ),
                  );
                } else {
                  onTapItem?.call(index);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
