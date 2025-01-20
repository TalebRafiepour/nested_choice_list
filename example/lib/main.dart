import 'package:flutter/material.dart';
import 'package:nested_choice_list/nested_choice_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NestedChoiceList Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// Home page

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showSelectedItems = true;
  bool enableSelectAll = true;
  bool showNavigationPath = false;
  bool enableMultiSelect = false;
  bool enableSearch = false;

  //
  NestedChoiceEntity? selectedItem;
  List<NestedChoiceEntity>? selectedItems;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NestedChoiceList'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CheckboxListTile.adaptive(
                title: const Text('ShowNavigationPath'),
                value: showNavigationPath,
                onChanged: (newValue) {
                  setState(() {
                    showNavigationPath = newValue ?? false;
                  });
                },
              ),
              const Divider(),
              CheckboxListTile.adaptive(
                title: const Text('EnableMultiSelect'),
                value: enableMultiSelect,
                onChanged: (newValue) {
                  setState(() {
                    enableMultiSelect = newValue ?? false;
                  });
                },
              ),
              const Divider(),
              CheckboxListTile.adaptive(
                title: const Text('EnableSelectAll'),
                value: enableSelectAll,
                onChanged: (newValue) {
                  setState(() {
                    enableSelectAll = newValue ?? false;
                  });
                },
              ),
              const Divider(),
              CheckboxListTile.adaptive(
                title: const Text('ShowSelectedItems'),
                value: showSelectedItems,
                onChanged: (newValue) {
                  setState(() {
                    showSelectedItems = newValue ?? false;
                  });
                },
              ),
              const Divider(),
              CheckboxListTile.adaptive(
                title: const Text('EnableSearch'),
                value: enableSearch,
                onChanged: (newValue) {
                  setState(() {
                    enableSearch = newValue ?? false;
                  });
                },
              ),
              const Divider(),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DemoOfNestedChoiceList(
                        items: items,
                        showSelectedItems: showSelectedItems,
                        enableSelectAll: enableSelectAll,
                        showNavigationPath: showNavigationPath,
                        enableMultiSelect: enableMultiSelect,
                        enableSearch: enableSearch,
                      ),
                    ),
                  );
                  if (result is NestedChoiceEntity) {
                    setState(() {
                      selectedItem = result;
                      selectedItems = null;
                    });
                  } else if (result is List<NestedChoiceEntity>) {
                    setState(() {
                      selectedItem = null;
                      selectedItems = result;
                    });
                  }
                },
                child: const Text(
                  'Show Demo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              const Text(
                '⇩ Result ⇩',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (selectedItem != null)
                Text(
                  'onTapItem: ${selectedItem!.label}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              if (selectedItems != null)
                Text(
                  'onSelectionChange: $selectedItems',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class DemoOfNestedChoiceList extends StatelessWidget {
  const DemoOfNestedChoiceList({
    required this.items,
    super.key,
    required this.showSelectedItems,
    required this.enableSelectAll,
    required this.showNavigationPath,
    required this.enableMultiSelect,
    required this.enableSearch,
  });

  final List<NestedChoiceEntity> items;
  final bool showSelectedItems;
  final bool enableSelectAll;
  final bool showNavigationPath;
  final bool enableMultiSelect;
  final bool enableSearch;

  @override
  Widget build(BuildContext context) {
    List<NestedChoiceEntity> selectedItems = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo'),
      ),
      body: NestedChoiceList(
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

        /// Callback function triggered when the navigation changes.
        /// Useful for handling UI updates based on the current page index.
        onNavigationChange: (pageIndex) {
          debugPrint('onNavigationChange -> pageIndex: $pageIndex');
        },
      ),
      bottomNavigationBar: enableMultiSelect
          ? SafeArea(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(selectedItems);
                },
                child: const Text('Confirm selected items'),
              ),
            )
          : null,
    );
  }
}
