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
      home: const MyHomePage(
        title: 'Two level nested choice list with single selection',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final items = [
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
        title: Text(widget.title),
      ),
      drawer: NestedChoiceList(
        items: items,
      ),
      body: const Center(child: Text('Nested Choice List'),),
    );
  }
}
