class DatabaseModel {
  int? id;
  String title;
  String description;

  DatabaseModel({required this.title, required this.description, this.id});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }
}
