import 'package:examples/multi_selection_example.dart';
import 'package:examples/single_selection_example.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// Home page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NestedChoiceList'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SingleSelectionExample(items: items,),
                  ),
                );
              },
              child: const Text('Example one (SingleSelection)'),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MultiSelectionExample(items: items,),
                  ),
                );
              },
              child: const Text('Example two (MultiSelection)'),
            ),
          ],
        ),
      ),
    );
  }
}
