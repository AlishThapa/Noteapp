import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/screens/todo/db/database_service_todoApp.dart';
import '../models/todo_model.dart';

class TodoCubit extends Cubit<List<TodoModels>> {
  TodoCubit() : super([]);

  void updateTodo({required TodoModels title, required int i}) {
    List<TodoModels> todos = [...state];
    todos[i] = title;
    emit(todos);
  }

  void add() async {
    List<TodoModels> todo = await DatabaseTodoService().readTodo();
    emit(todo);
  }

  void delete({required int i}) {
    List<TodoModels> todos = [...state];
    todos.removeAt(i);
    emit(todos);
  }
}
