class NoteModel {
  int? id;
  String title;
  String description;

  NoteModel({
    required this.title,
    required this.description,
    this.id,
  });

  NoteModel copyWith({String? title, String? description}) {
    return NoteModel(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
