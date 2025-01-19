import 'package:flutter/foundation.dart';

/// A class representing a nested choice entity.
///
/// This class is used to define an entity that can be used
/// in a nested choice list.
/// It is generic and can work with any type that extends `Object`.
///
/// Type Parameters:
/// - `T`: The type of the entity, which must extend `Object`.
///
/// Example:
/// ```dart
/// NestedChoiceEntity<String> entity =
/// NestedChoiceEntity<String>(value: 'value', label: 'label');
/// ```
@immutable
class NestedChoiceEntity<T extends Object> {
  const NestedChoiceEntity({
    required this.value,
    required this.label,
    this.isDisabled = false,
    this.children = const [],
  });

  /// Creates a new instance of [NestedChoiceEntity] from a JSON map.
  ///
  /// The [json] parameter is a map containing the key-value pairs that
  /// represent the properties of the [NestedChoiceEntity].
  ///
  /// The `value` field is extracted from the JSON map and cast to type [T].
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
    return NestedChoiceEntity<T>(
      value: json['value'] as T,
      label: json['label'] as String,
      isDisabled: json['isDisabled'] as bool? ?? false,
      children: (json['children'] as List<dynamic>?)
              ?.map(
                (e) =>
                    NestedChoiceEntity<T>.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  /// The value associated with this entity.
  ///
  /// This is a generic type [T] which allows the entity to hold any
  /// type of value.
  final T value;

  /// The label associated with this nested choice entity.
  final String label;

  /// Indicates whether the choice is disabled.
  ///
  /// When set to `true`, the choice is not selectable or interactable.
  final bool isDisabled;

  /// A list of child entities of type `NestedChoiceEntity<T>`.
  ///
  /// This list represents the nested structure of choices, where each
  /// `NestedChoiceEntity` can have its own children, forming a tree-like
  /// hierarchy.
  final List<NestedChoiceEntity<T>> children;

  /// Adds a child [NestedChoiceEntity] to the list of children.
  ///
  /// The [child] parameter is the entity to be added to the children list.
  ///
  /// Example:
  /// ```dart
  /// const parent =
  ///      NestedChoiceEntity<String>(value: 'parent', label: 'Parent');
  /// const child =
  ///        NestedChoiceEntity<String>(value: 'child', label: 'Child');
  ///
  /// final updatedParent = parent.add(child);
  /// ```
  NestedChoiceEntity<T> add(NestedChoiceEntity<T> child) {
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
  NestedChoiceEntity<T> addAll(Iterable<NestedChoiceEntity<T>> children) {
    //becuase of immutability, we need to create a new instance of the entity
    return copyWith(
      children: [...this.children, ...children],
    );
  }

  /// Checks if the current entity has any children.
  ///
  /// Returns `true` if the `children` list is not empty, otherwise `false`.
  bool get hasChildren => children.isNotEmpty;

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
  NestedChoiceEntity<T> copyWith({
    T? value,
    String? label,
    bool? isDisabled,
    List<NestedChoiceEntity<T>>? children,
  }) {
    return NestedChoiceEntity<T>(
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
    if (hasChildren) {
      return '{$label : [${children.map((e) => e.toString()).join(', ')}],}';
    } else {
      return '{$label}';
    }
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
