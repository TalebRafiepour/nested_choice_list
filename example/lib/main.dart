import 'package:examples/example_one.dart';
import 'package:flutter/material.dart';
import 'package:nested_choice_list/nested_choice_list.dart';

const items = [
  NestedChoiceEntity(
    value: 'value1',
    label: 'label1 level1',
    children: [
      NestedChoiceEntity(value: 'value2', label: 'label1 level 2'),
      NestedChoiceEntity(value: 'value3', label: 'label1 level 2'),
      NestedChoiceEntity(
        value: 'value4',
        label: 'label1.2 level 2',
        children: [
          NestedChoiceEntity(value: 'value2', label: 'label1.2 level 3'),
          NestedChoiceEntity(value: 'value3', label: 'label1.2 level 3'),
          NestedChoiceEntity(
            value: 'value4',
            label: 'label1.3 level 3',
            children: [
              NestedChoiceEntity(value: 'value2', label: 'label1.3 level 4'),
              NestedChoiceEntity(value: 'value3', label: 'label1.3 level 4'),
              NestedChoiceEntity(value: 'value4', label: 'label1.3 level 4'),
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
      NestedChoiceEntity(value: 'value3', label: 'label2 level 2'),
      NestedChoiceEntity(
        value: 'value4',
        label: 'label2.1 level 2',
        children: [
          NestedChoiceEntity(value: 'value2', label: 'label2.1 level 3'),
          NestedChoiceEntity(value: 'value3', label: 'label2.1 level 3'),
          NestedChoiceEntity(value: 'value4', label: 'label2.1 level 3'),
        ],
      ),
    ],
  ),
  NestedChoiceEntity(
    value: 'value3',
    label: 'label3 level1',
    children: [
      NestedChoiceEntity(value: 'value2', label: 'label3 level 2'),
      NestedChoiceEntity(value: 'value3', label: 'label3 level 2'),
      NestedChoiceEntity(value: 'value4', label: 'label3 level 2'),
    ],
  ),
  NestedChoiceEntity(value: 'value4', label: 'label4 level1'),
];

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NestedChoiceList'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 28,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ExampleOne(),
                      ),
                    );
                  },
                  child: const Text('Example One'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
