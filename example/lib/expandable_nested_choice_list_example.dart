import 'package:flutter/material.dart';
import 'package:nested_choice_list/nested_choice_list.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ExpandableNestedChoiceListExample(),
    ),
  );
}

class ExpandableNestedChoiceListExample extends StatefulWidget {
  const ExpandableNestedChoiceListExample({super.key});

  @override
  State<ExpandableNestedChoiceListExample> createState() =>
      _ExpandableNestedChoiceListExampleState();
}

class _ExpandableNestedChoiceListExampleState
    extends State<ExpandableNestedChoiceListExample> {
  final _scafoldKey = GlobalKey<ScaffoldState>();
  final items = const [
    NestedChoiceEntity(label: 'All documents'),
    NestedChoiceEntity(label: 'Favorites'),
    NestedChoiceEntity(
      label: 'Templates',
      children: [
        NestedChoiceEntity(label: 'Onboarding'),
        NestedChoiceEntity(
          label: 'New project',
          children: [
            NestedChoiceEntity(label: 'Timesheet'),
            NestedChoiceEntity(label: 'Statement of work'),
            NestedChoiceEntity(label: 'Scope'),
          ],
        ),
      ],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      drawer: NestedChoiceList.expandable(
        items: items,
      ),
      body: Center(
        child: Column(
          spacing: 28,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Expandable Nested Choice List \n open drawer to see the example',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ElevatedButton(
              onPressed: () {
                _scafoldKey.currentState?.openDrawer();
              },
              child: Text(
                'Open',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
