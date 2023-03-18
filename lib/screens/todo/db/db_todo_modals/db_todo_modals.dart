class DatabaseModelTodo {
  int? id;
  String title;

  DatabaseModelTodo({required this.title, this.id});

  Map<String, dynamic> toMap() {
    return {
      'todo': title,
    };
  }
}
