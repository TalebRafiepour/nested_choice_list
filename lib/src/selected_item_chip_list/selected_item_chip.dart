import 'package:flutter/material.dart';

class SelectedItemChip extends StatelessWidget {
  const SelectedItemChip({
    required this.title,
    this.onDeleted,
    super.key,
  });

  final String title;
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Chip(
        padding: const EdgeInsets.all(4),
        color: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.primary,
        ),
        elevation: 0,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        deleteIcon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 18,
        ),
        onDeleted: onDeleted,
        label: Text(
          title,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
