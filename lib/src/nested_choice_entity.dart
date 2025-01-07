import 'package:flutter/foundation.dart';

@immutable
class NestedChoiceEntity<T extends Object> {
  const NestedChoiceEntity({
    required this.value,
    required this.label,
    this.isDisabled = false,
    this.children = const [],
  });

  final T value;
  final String label;
  final bool isDisabled;
  final List<NestedChoiceEntity<T>> children;

  void add(NestedChoiceEntity<T> child) {
    children.add(child);
  }

  void addAll(Iterable<NestedChoiceEntity<T>> children) {
    this.children.addAll(
          children,
        );
  }

  bool get hasChildren => children.isNotEmpty;

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

  @override
  String toString() {
    if (hasChildren) {
      return '{$label : [${children.map((e) => e.toString()).join(', ')}],}';
    } else {
      return '{$label}';
    }
  }

  @override
  int get hashCode => Object.hash(
        label,
        value,
        isDisabled,
        children,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return (other is NestedChoiceEntity) &&
        label == other.label &&
        value == other.value &&
        children == other.children;
  }
}
