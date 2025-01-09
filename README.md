A flutter package for handling nested list item selection without limitation for the depth of the nested list.

## Installation

To use NestedChoiceList, you need to add it to your pubspec.yaml file:

```yaml
dependencies:
  nested_choice_list: latest_version
```

Then, run `flutter pub get` to install the package.

## Usage
To use NestedChoiceList in your Flutter app, first import the package:

```dart
import 'package:nested_choice_list/nested_choice_list.dart';
```

## NestedChoiceList Demo showcase

### First initialize your items

```dart
final items = const [
    NestedChoiceEntity(
      value: 'value1',
      label: 'label1 level1',
      children: [
        NestedChoiceEntity(value: 'value2', label: 'label2 level 2'),
        NestedChoiceEntity(value: 'value3', label: 'label3 level 2'),
        NestedChoiceEntity(
          value: 'value4',
          label: 'label4 level 2',
          children: [
            NestedChoiceEntity(value: 'value2', label: 'label2 level 3'),
            NestedChoiceEntity(value: 'value3', label: 'label3 level 3'),
            NestedChoiceEntity(
              value: 'value4',
              label: 'label4',
              children: [
                NestedChoiceEntity(value: 'value2', label: 'label2 level 4'),
                NestedChoiceEntity(value: 'value3', label: 'label3 level 4'),
                NestedChoiceEntity(value: 'value4', label: 'label4 level 4'),
              ],
            ),
          ],
        ),
      ],
    ),
    NestedChoiceEntity(
      value: 'value2',
      label: 'label2 level1',
      children: [
        NestedChoiceEntity(value: 'value2', label: 'label2 level 2'),
        NestedChoiceEntity(value: 'value3', label: 'label3 level 2'),
        NestedChoiceEntity(
          value: 'value4',
          label: 'label4 level 2',
          children: [
            NestedChoiceEntity(value: 'value2', label: 'label2 level 3'),
            NestedChoiceEntity(value: 'value3', label: 'label3 level 3'),
            NestedChoiceEntity(value: 'value4', label: 'label4 level 3'),
          ],
        ),
      ],
    ),
    NestedChoiceEntity(
      value: 'value3',
      label: 'label3 level1',
      children: [
        NestedChoiceEntity(value: 'value2', label: 'label2 level 2'),
        NestedChoiceEntity(value: 'value3', label: 'label3 level 2'),
        NestedChoiceEntity(value: 'value4', label: 'label4 level 2'),
      ],
    ),
    NestedChoiceEntity(value: 'value4', label: 'label4 level1'),
  ];
```

### Then pass your items to the widget and use it

```dart
NestedChoiceList(
        items: items,
        showSelectedItems: showSelectedItems,
        enableSelectAll: enableSelectAll,
        showNavigationPath: showNavigationPath,
        enableMultiSelect: enableMultiSelect,
        enableSearch: enableSearch,
        style: const NestedListStyle(),
        // this callback triggers when we are in
        // single select mode (enableMultiSelect = false)
        onTapItem: (item) {
          debugPrint('onTapItem -> $item');
          Navigator.of(context).pop(item);
        },
        // this callback triggers when we are in
        // multi select mode (enableMultiSelect = true)
        onSelectionChange: (items) {
          debugPrint('onSelectionChange -> $items');
          selectedItems = items;
        },
      )
```

## License

NestedChoiceList is released under the `BSD-3-Clause` License.
