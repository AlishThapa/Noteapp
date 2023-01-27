class TodoModels {
  bool isChecked;
  String title;

  TodoModels({this.isChecked= false, required this.title});

  TodoModels copyWith ({bool? isChecked, String? title}){
    return TodoModels(
        isChecked : isChecked ?? this.isChecked,
        title: title?? this.title);
  }
}