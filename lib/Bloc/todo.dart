import 'package:flutter_bloc/flutter_bloc.dart';
import '../Models/todo_model.dart';

class TodoCubit extends Cubit<List<TodoModels>>{
  TodoCubit():super([]);

  void updateTodo({required TodoModels title, required int i}){
    List<TodoModels> todos = [...state];
    todos[i]= title;
    emit(todos);
  }

  void add({required TodoModels title}){
    List<TodoModels> todos = [...state];
    todos.add(title);
    emit(todos);
  }

  void delete({required int i}){
    List<TodoModels> todos = [...state];
    todos.removeAt(i);
    emit(todos);
  }

}