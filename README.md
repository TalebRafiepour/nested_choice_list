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
* Include a callback function for handling page changes with `onNavigationChange`.
* Include customizable styles via `NestedListStyle`.
* Supports both expandable and navigation modes for displaying items, which can be set using `NestedChoiceListType`.

## Showcase
### Single selection mode
| showNavigationPath=true | enableSearch=true |
|-------------------------|-------------------|
| ![single-select-showNavigationPath](https://github.com/TalebRafiepour/showcase/blob/main/nested_choice_list/single-select-with-navigation-path.gif?raw=true) | ![single-select-enableSearch](https://github.com/TalebRafiepour/showcase/blob/main/nested_choice_list/single-select-with-search.gif?raw=true) |

------------------------------------------------

### Multiple selection mode
|enableMultiSelect=true| showSelectedItem=true |
|----------------------|-----------------------|
| ![multi-select-with-select-all](https://github.com/TalebRafiepour/showcase/blob/main/nested_choice_list/multi-selection-with-select-all.gif?raw=true) | ![multi-select-with-show-selected-items](https://github.com/TalebRafiepour/showcase/blob/main/nested_choice_list/multi-select-show-selected-item.gif?raw=true) |

|expandable mode|
|---------------|
| ![expandable-mode](https://github.com/TalebRafiepour/showcase/blob/main/nested_choice_list/expandable-mode.gif?raw=true) |


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
        /// A list of items to be displayed in the nested choice list.
        items: items,
        /// A flag to determine whether to display the selected items.
        showSelectedItems: showSelectedItems,
        /// Enables or disables the "Select All" option in the list.
        enableSelectAll: enableSelectAll,
        /// A flag to determine whether to show the navigation path.
        showNavigationPath: showNavigationPath,
        /// Enables or disables multi-select functionality.
        enableMultiSelect: enableMultiSelect,
        /// Enables or disables the search functionality in the list.
        enableSearch: enableSearch,
        /// Applies a constant style to the nested list.
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
        /// Callback function triggered when the navigation changes.
        /// Useful for handling UI updates based on the current page index.
        onNavigationChange: (pageIndex) {
          debugPrint('onNavigationChange -> pageIndex: $pageIndex');
        },
      )
```

## Support the Package

If you find `NestedChoiceList` useful, please consider supporting it by:

* Liking the package on [pub.dev](https://pub.dev/packages/nested_choice_list).
* Starring the repository on [GitHub](https://github.com/TalebRafiepour/nested_choice_list).
* Reporting any issues or bugs you encounter [here](https://github.com/TalebRafiepour/nested_choice_list/issues).

Your support helps improve the package and ensures its continued development.

## License

NestedChoiceList is released under the `BSD-3-Clause` License.

## Contact Me 📨

Feel free to reach out to me through the following platforms:

<a href="https://github.com/TalebRafiepour"><img src= "https://img.icons8.com/ios-glyphs/344/github.png" width = "40px"/></a> <a href="https://www.linkedin.com/in/taleb-rafiepour/"><img src= "https://img.icons8.com/color/344/linkedin.png" width = "40px"/></a> <a href="mailto:taleb.r75@gmail.com"><img src= "https://img.icons8.com/color/344/gmail-new.png" width = "40px"/></a>

I look forward to connecting with you!
