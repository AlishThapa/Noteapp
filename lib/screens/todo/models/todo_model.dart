class TodoModels {
  int? id;
  bool isChecked;
  String todo;

  TodoModels({
    this.isChecked = false,
    required this.todo,
    this.id,
  });

  TodoModels copyWith({bool? isChecked, String? todo}) {
    return TodoModels(
      isChecked: isChecked ?? this.isChecked,
      todo: todo ?? this.todo,
    );
  }
}
