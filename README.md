# NestedChoiceList
[![Pub Version](https://img.shields.io/pub/v/nested_choice_list.svg?label=pub&color=blue)](https://pub.dev/packages/nested_choice_list/versions)
[![GitHub Stars](https://img.shields.io/github/stars/TalebRafiepour/nested_choice_list?color=yellow&label=Stars)](https://github.com/TalebRafiepour/nested_choice_list/stargazers)
[![GitHub opened issues](https://img.shields.io/github/issues/TalebRafiepour/nested_choice_list?color=red)](https://github.com/TalebRafiepour/nested_choice_list/issues)
[![GitHub closed issues](https://img.shields.io/github/issues-closed/TalebRafiepour/nested_choice_list)](https://github.com/TalebRafiepour/nested_choice_list/issues?q=is%3Aissue+is%3Aclosed)
![GitHub License](https://img.shields.io/github/license/TalebRafiepour/nested_choice_list)

A powerful Flutter package designed to simplify the selection of items from deeply nested lists. With its robust features, you can create intuitive and flexible user interfaces that enhance the user experience without the constraints of traditional list handling.

## Features

* Create a list widget with a nesting depth ranging from 0 to infinite.
* Support single selection and multiple selection modes.
* Display the navigation path of selections through the nested list.
* Enable search filtering across every page of the nested list.
* Show the selected items at the top of the page.
* Allow selecting all items in multi-selection mode.
* Provide a callback for single selection mode: `onTapItem`.
* Offer a callback for multi-selection mode: `onSelectionChange`.
* Include customizable styles via `NestedListStyle`.

## Showcase
### Single selection mode
| default single selection| showNavigationPath=true |    enableSearch=true    |
|-------------------------|-------------------------|-------------------------|
| ![single-select](https://github.com/TalebRafiepour/showcase/blob/main/nested_choice_list/single-select.gif?raw=true) | ![single-select-showNavigationPath](https://github.com/TalebRafiepour/showcase/blob/main/nested_choice_list/single-select-with-navigation-path.gif?raw=true) | ![single-select-enableSearch](https://github.com/TalebRafiepour/showcase/blob/main/nested_choice_list/single-select-with-search.gif?raw=true) |

------------------------------------------------

### Multiple selection mode
| default multi selection |   enableSelectAll=true  |  showSelectedItem=true  |
|-------------------------|-------------------------|-------------------------|
| ![multi-select](https://github.com/TalebRafiepour/showcase/blob/main/nested_choice_list/multi-select.gif?raw=true) | ![multi-select-with-select-all](https://github.com/TalebRafiepour/showcase/blob/main/nested_choice_list/multi-select-with-select-all.gif?raw=true) | ![multi-select-with-show-selected-items](https://github.com/TalebRafiepour/showcase/blob/main/nested_choice_list/multi-select-show-selected-item.gif?raw=true) |


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

### Initialize your items using NestedChoiceEntity class

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
              label: 'label4 level 3',
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

### Or Initialize your items using Json map

```dart
final jsonMap = const [
    {
      'value': 'value1',
      'label': 'label1 level1',
      'isDisabled': false,
      'children': [
        {
          'value': 'value2',
          'label': 'label2 level 2',
        },
        {
          'value': 'value3',
          'label': 'label3 level 2',
        },
        {
          'value': 'value4',
          'label': 'label4 level 2',
          'children': [
            {
              'value': 'value2',
              'label': 'label2 level 3',
            },
            {
              'value': 'value3',
              'label': 'label3 level 3',
            },
            {
              'value': 'value4',
              'label': 'label4 level 3',
              'children': [
                {
                  'value': 'value2',
                  'label': 'label2 level 4',
                },
                {
                  'value': 'value3',
                  'label': 'label3 level 4',
                },
                {
                  'value': 'value4',
                  'label': 'label4 level 4',
                }
              ]
            }
          ]
        }
      ]
    },
    {
      'value': 'value2',
      'label': 'label2 level1',
      'children': [
        {
          'value': 'value2',
          'label': 'label2 level 2',
        },
        {
          'value': 'value3',
          'label': 'label3 level 2',
        },
        {
          'value': 'value4',
          'label': 'label4 level 2',
          'children': [
            {
              'value': 'value2',
              'label': 'label2 level 3',
            },
            {
              'value': 'value3',
              'label': 'label3 level 3',
            },
            {
              'value': 'value4',
              'label': 'label4 level 3',
            }
          ]
        }
      ]
    },
    {
      'value': 'value3',
      'label': 'label3 level1',
      'children': [
        {
          'value': 'value2',
          'label': 'label2 level 2',
        },
        {
          'value': 'value3',
          'label': 'label3 level 2',
        },
        {
          'value': 'value4',
          'label': 'label4 level 2',
        }
      ]
    },
    {
      'value': 'value4',
      'label': 'label4 level1',
    }
  ];

final items = jsonMap.map((e) => NestedChoiceEntity.fromJson(e)).toList();
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
