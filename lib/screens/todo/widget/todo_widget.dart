import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/screens/todo/db/database_service_todoApp.dart';
import 'package:noteapp/screens/todo/db/db_todo_modals/db_todo_modals.dart';
import 'package:noteapp/screens/todo/models/todo_model.dart';

import '../todo_bloc/todo_bloc.dart';

class TodoWidget extends StatelessWidget {
  TodoWidget({Key? key, required this.todo, this.index}) : super(key: key);

  final TextEditingController todo;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white12.withOpacity(0.2),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 25),
            height: 40,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.teal.withOpacity(0.4), Colors.white10.withOpacity(0.9)],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: todo,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Add to do list',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please write a todo';
                }
                return null;
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              if (todo.text.isNotEmpty) {
                Navigator.pop(context);
                DatabaseTodoService().create(DatabaseModelTodo(title: todo.text.trim()));
                context.read<TodoCubit>().add();
                todo.clear();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Todo cannot be empty!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 35,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: const LinearGradient(colors: [Colors.orange, Colors.yellow], begin: Alignment.bottomLeft, end: Alignment.topRight),
              ),
              child: const Text(
                'Add',
              ),
            ),
          )
        ],
      ),
    );
  }
}
