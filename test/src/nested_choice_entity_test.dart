import 'package:flutter_test/flutter_test.dart';
import 'package:nested_choice_list/src/nested_choice_entity.dart';

void main() {
  group('NestedChoiceEntity Tests', () {
    test('constructor initializes correctly', () {
      const entity = NestedChoiceEntity(value: '1', label: 'Item 1');
      expect(entity.value, '1');
      expect(entity.label, 'Item 1');
      expect(entity.isDisabled, false);
      expect(entity.children, isEmpty);
    });

    test('add method adds a child entity', () {
      const parent = NestedChoiceEntity(value: '1', label: 'Parent');
      const child = NestedChoiceEntity(value: '2', label: 'Child');
      // because the add method returns a new instance of the entity
      final updatedParent = parent.add(child);
      expect(updatedParent.children, contains(child));
    });

    test('addAll method adds multiple child entities', () {
      const parent = NestedChoiceEntity(value: '1', label: 'Parent');
      const child1 = NestedChoiceEntity(value: '2', label: 'Child 1');
      const child2 = NestedChoiceEntity(value: '3', label: 'Child 2');
      final updatedParent = parent.addAll([child1, child2]);
      expect(updatedParent.children, containsAll([child1, child2]));
    });

    test('hasChildren getter returns true if there are children', () {
      const parent = NestedChoiceEntity(value: '1', label: 'Parent');
      const child = NestedChoiceEntity(value: '2', label: 'Child');
      final updatedParent = parent.add(child);
      expect(updatedParent.hasChildren, isTrue);
    });

    test('hasChildren getter returns false if there are no children', () {
      const entity = NestedChoiceEntity(value: '1', label: 'Item 1');
      expect(entity.hasChildren, isFalse);
    });

    test('copyWith method creates a copy with updated values', () {
      const entity = NestedChoiceEntity(value: '1', label: 'Item 1');
      final copiedEntity = entity.copyWith(label: 'Updated Item');
      expect(copiedEntity.label, 'Updated Item');
      expect(copiedEntity.value, '1');
    });

    test('toString method returns correct JSON string representation', () {
      const entity = NestedChoiceEntity(value: '1', label: 'Item 1');
      expect(
        entity.toString(),
        '{"value":"1","label":"Item 1","isDisabled":false,"children":[]}',
      );
    });

    test('hashCode returns correct hash code', () {
      const entity1 = NestedChoiceEntity(value: '1', label: 'Item 1');
      const entity2 = NestedChoiceEntity(value: '1', label: 'Item 1');
      expect(entity1.hashCode, entity2.hashCode);
    });

    test('== operator returns true for identical entities', () {
      const entity1 = NestedChoiceEntity(value: '1', label: 'Item 1');
      const entity2 = NestedChoiceEntity(value: '1', label: 'Item 1');
      expect(entity1 == entity2, isTrue);
    });

    test('== operator returns false for different entities', () {
      const entity1 = NestedChoiceEntity(value: '1', label: 'Item 1');
      const entity2 = NestedChoiceEntity(value: '2', label: 'Item 2');
      expect(entity1 == entity2, isFalse);
    });
  });

  test('fromJson creates an instance from JSON', () {
    final json = {
      'value': '1',
      'label': 'Item 1',
      'isDisabled': false,
      'children': [
        {
          'value': '2',
          'label': 'Child 1',
          'isDisabled': false,
          'children': [],
        },
      ],
    };
    final entity = NestedChoiceEntity.fromJson(json);
    expect(entity.value, '1');
    expect(entity.label, 'Item 1');
    expect(entity.isDisabled, false);
    expect(entity.children.length, 1);
    expect(entity.children.first.value, '2');
    expect(entity.children.first.label, 'Child 1');
  });

  test('toJson converts an instance to JSON', () {
    const entity = NestedChoiceEntity(
      value: '1',
      label: 'Item 1',
      children: [
        NestedChoiceEntity(value: '2', label: 'Child 1'),
      ],
    );
    final json = entity.toJson();
    expect(json['value'], '1');
    expect(json['label'], 'Item 1');
    expect(json['isDisabled'], false);
    expect((json['children'] as List<Map<String, dynamic>>).length, 1);
    expect(
      (json['children'] as List<Map<String, dynamic>>)[0]['value'],
      '2',
    );
    expect(
      (json['children'] as List<Map<String, dynamic>>)[0]['label'],
      'Child 1',
    );
  });

  test('leafChildren getter returns only entities without children', () {
    const parent = NestedChoiceEntity(
      value: '1',
      label: 'Parent',
      children: [
        NestedChoiceEntity(value: '2', label: 'Child 1'),
        NestedChoiceEntity(
          value: '3',
          label: 'Child 2',
          children: [
            NestedChoiceEntity(value: '4', label: 'Grandchild 1'),
          ],
        ),
      ],
    );
    final leafChildren = parent.leafChildren;
    expect(leafChildren.length, 1);
    expect(leafChildren.first.value, '2');
  });
}
