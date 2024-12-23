class NestedChoiceEntity<T> {
  NestedChoiceEntity({
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
    this.children.addAll(children);
  }

  bool get hasChildren => children.isNotEmpty;

  @override
  String toString() {
    if (children.isNotEmpty) {
      return '{$label : [${children.map((e) => e.toString()).join(', ')}],}';
    } else {
      return '{$label}';
    }
  }
}
