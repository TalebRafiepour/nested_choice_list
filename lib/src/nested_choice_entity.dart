class NestedChoiceEntity<T extends Object> {
  const NestedChoiceEntity({
    required this.value,
    required this.label,
    this.isDisabled = false,
    this.group,
    this.children = const [],
  });

  final T value;
  final String label;
  final bool isDisabled;
  final String? group;
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
    String? group,
    List<NestedChoiceEntity<T>>? children,
  }) {
    return NestedChoiceEntity<T>(
      value: value ?? this.value,
      label: label ?? this.label,
      isDisabled: isDisabled ?? this.isDisabled,
      group: group ?? this.group,
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
}
