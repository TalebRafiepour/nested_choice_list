A flutter package for handling nested list item selection without limitation for the depth of the nested list.

## NestedChoiceList with single item selection example

```dart
import 'package:flutter/material.dart';
import 'package:nested_choice_list/nested_choice_list.dart';

class SingleSelectionExample extends StatelessWidget {
  const SingleSelectionExample({super.key});

  final items = const [
    NestedChoiceEntity(
      value: 'value1',
      label: 'label1',
      children: [
        NestedChoiceEntity(value: 'value2', label: 'label2'),
        NestedChoiceEntity(value: 'value3', label: 'label3'),
        NestedChoiceEntity(value: 'value4', label: 'label4'),
      ],
    ),
    NestedChoiceEntity(
      value: 'value2',
      label: 'label2',
      children: [
        NestedChoiceEntity(value: 'value2', label: 'label2'),
        NestedChoiceEntity(value: 'value3', label: 'label3'),
        NestedChoiceEntity(
          value: 'value4',
          label: 'label4',
          children: [
            NestedChoiceEntity(value: 'value2', label: 'label2'),
            NestedChoiceEntity(value: 'value3', label: 'label3'),
            NestedChoiceEntity(value: 'value4', label: 'label4'),
          ],
        ),
      ],
    ),
    NestedChoiceEntity(
      value: 'value3',
      label: 'label3',
      children: [
        NestedChoiceEntity(value: 'value2', label: 'label2'),
        NestedChoiceEntity(value: 'value3', label: 'label3'),
        NestedChoiceEntity(value: 'value4', label: 'label4'),
      ],
    ),
    NestedChoiceEntity(value: 'value4', label: 'label4'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Nested Choice List with single selection'),
      ),
      body: NestedChoiceList(
        items: items,
        onTapItem: (item) {
          print(item);
          Navigator.pop(context);
        },
      ),
    );
  }
}

```

## NestedChoiceList with multiple item selection example

```dart
import 'package:flutter/material.dart';
import 'package:nested_choice_list/nested_choice_list.dart';

class MultiSelectionExample extends StatelessWidget {
  const MultiSelectionExample({super.key});

  final items =  const [
    NestedChoiceEntity(
      value: 'value1',
      label: 'label1',
      children: [
        NestedChoiceEntity(value: 'value2', label: 'label2'),
        NestedChoiceEntity(value: 'value3', label: 'label3'),
        NestedChoiceEntity(value: 'value4', label: 'label4'),
      ],
    ),
    NestedChoiceEntity(
      value: 'value2',
      label: 'label2',
      children: [
        NestedChoiceEntity(value: 'value2', label: 'label2'),
        NestedChoiceEntity(value: 'value3', label: 'label3'),
        NestedChoiceEntity(
          value: 'value4',
          label: 'label4',
          children: [
            NestedChoiceEntity(value: 'value2', label: 'label2'),
            NestedChoiceEntity(value: 'value3', label: 'label3'),
            NestedChoiceEntity(value: 'value4', label: 'label4'),
          ],
        ),
      ],
    ),
    NestedChoiceEntity(
      value: 'value3',
      label: 'label3',
      children: [
        NestedChoiceEntity(value: 'value2', label: 'label2'),
        NestedChoiceEntity(value: 'value3', label: 'label3'),
        NestedChoiceEntity(value: 'value4', label: 'label4'),
      ],
    ),
    NestedChoiceEntity(value: 'value4', label: 'label4'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Nested Choice List with mulitple selection'),
      ),
      body: NestedChoiceList(
        items: items,
        isMultiSelect: true,
        onTapItem: (item) {
          print(item);
        },
      ),
    );
  }
}
```
