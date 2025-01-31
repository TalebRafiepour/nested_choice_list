import 'dart:convert';

import 'package:flutter/foundation.dart';

/// A class representing a nested choice entity.
///
/// This class is used to represent an entity with a value, label, and optional
/// children entities. It can also be marked as disabled.
///
/// The [NestedChoiceEntity] class is immutable, meaning its properties cannot
/// be changed after it is created.
///
/// Properties:
/// - [label]: The label of the entity.
/// - [isDisabled]: A boolean indicating whether the entity is disabled.
///   Defaults to `false`.
/// - [children]: A list of child entities. Defaults to an empty list.
/// - [value]: The value of the entity.
///
/// Example:
/// ```dart
/// NestedChoiceEntity entity =
/// NestedChoiceEntity(value: 'value', label: 'label');
/// ```
@immutable
class NestedChoiceEntity {
  const NestedChoiceEntity({
    required this.label,
    this.isDisabled = false,
    this.children = const [],
    this.value,
  });

  /// Creates a new instance of [NestedChoiceEntity] from a JSON map.
  ///
  /// The [json] parameter is a map containing the key-value pairs that
  /// represent the properties of the [NestedChoiceEntity].
  ///
  /// The `value` field is extracted from the JSON map and can
  /// be any type or null.
  /// The `label` field is extracted as a [String].
  /// The `isDisabled` field is extracted as a [bool], defaulting to `false`
  /// if not present.
  /// The `children` field is extracted as a list of dynamic objects, which
  /// are then mapped to a list of [NestedChoiceEntity] instances. If the
  /// `children` field is not present, an empty list is used.
  ///
  /// Returns a new instance of [NestedChoiceEntity] populated with the
  /// values from the JSON map.
  factory NestedChoiceEntity.fromJson(Map<String, dynamic> json) {
    return NestedChoiceEntity(
      value: json['value'],
      label: json['label'] as String,
      isDisabled: json['isDisabled'] as bool? ?? false,
      children: (json['children'] as List<dynamic>?)
              ?.map(
                (e) => NestedChoiceEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  /// The value associated with this entity.
  ///
  /// This can be any object, or null.
  final Object? value;

  /// The label associated with this nested choice entity.
  final String label;

  /// Indicates whether the choice is disabled.
  ///
  /// When set to `true`, the choice is not selectable or interactable.
  final bool isDisabled;

  /// A list of child `NestedChoiceEntity` objects.
  ///
  /// This list contains the nested choices that are associated with
  /// the current entity.
  final List<NestedChoiceEntity> children;

  /// Adds a child [NestedChoiceEntity] to the list of children.
  ///
  /// The [child] parameter is the entity to be added to the children list.
  ///
  /// Example:
  /// ```dart
  /// const parent =
  ///      NestedChoiceEntity(value: 'parent', label: 'Parent');
  /// const child =
  ///        NestedChoiceEntity(value: 'child', label: 'Child');
  ///
  /// final updatedParent = parent.add(child);
  /// ```
  NestedChoiceEntity add(NestedChoiceEntity child) {
    //becuase of immutability, we need to create a new instance of the entity
    return copyWith(
      children: [...children, child],
    );
  }

  /// Adds all the given [children] to the current list of children.
  ///
  /// This method takes an [Iterable] of [NestedChoiceEntity] objects and adds
  /// them to the existing list of children.
  ///
  /// - Parameter children: An iterable collection of [NestedChoiceEntity]
  ///   objects to be added to the current list of children.
  NestedChoiceEntity addAll(Iterable<NestedChoiceEntity> children) {
    //becuase of immutability, we need to create a new instance of the entity
    return copyWith(
      children: [...this.children, ...children],
    );
  }

  /// Checks if the current entity has any children.
  ///
  /// Returns `true` if the `children` list is not empty, otherwise `false`.
  bool get hasChildren => children.isNotEmpty;

  /// Returns a list of `NestedChoiceEntity` objects that do not have children.
  ///
  /// This getter filters the `children` list and includes only those entities
  /// that do not have any children (`hasChildren` is `false`).
  ///
  /// Example:
  /// ```dart
  /// List<NestedChoiceEntity> leafNodes = parentEntity.leafChildren;
  /// ```
  List<NestedChoiceEntity> get leafChildren =>
      children.where((e) => !e.hasChildren).toList();

  /// Creates a copy of this `NestedChoiceEntity` with the given fields replaced
  /// by new values.
  ///
  /// If a field is not provided, the current value of that field will be used.
  ///
  /// - `value`: The new value for the `value` field.
  /// - `label`: The new value for the `label` field.
  /// - `isDisabled`: The new value for the `isDisabled` field.
  /// - `children`: The new value for the `children` field.
  ///
  /// Returns a new `NestedChoiceEntity` instance with the updated values.
  NestedChoiceEntity copyWith({
    Object? value,
    String? label,
    bool? isDisabled,
    List<NestedChoiceEntity>? children,
  }) {
    return NestedChoiceEntity(
      value: value ?? this.value,
      label: label ?? this.label,
      isDisabled: isDisabled ?? this.isDisabled,
      children: children ?? this.children,
    );
  }

  /// Converts the `NestedChoiceEntity` instance to a JSON map.
  ///
  /// The returned map contains the following keys:
  /// - `value`: The value of the entity.
  /// - `label`: The label of the entity.
  /// - `isDisabled`: A boolean indicating if the entity is disabled.
  /// - `children`: A list of child entities, each converted to a JSON map.
  ///
  /// Returns a `Map<String, dynamic>` representing the JSON structure
  /// of the entity.
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'label': label,
      'isDisabled': isDisabled,
      'children': children.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  /// Overrides the `hashCode` getter to provide a hash code for the
  /// `NestedChoiceEntity` object based on its `label`, `value`,
  /// `isDisabled`, and `children` properties.
  ///
  /// This implementation uses the `Object.hash` method to combine
  /// the hash codes of these properties into a single hash code.
  @override
  int get hashCode => Object.hash(
        label,
        value,
        isDisabled,
        children,
      );

  /// Compares this instance with another object.
  ///
  /// Returns `true` if the other object is identical to this instance, or if
  /// the other object is a [NestedChoiceEntity] with the same [label], [value],
  /// and [children].
  ///
  /// The comparison is performed using the `==` operator for each field.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return (other is NestedChoiceEntity) &&
        label == other.label &&
        value == other.value &&
        children == other.children;
  }
}
