import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/Models/todo_model.dart';

import '../Bloc/todo.dart';


class TodoWidget extends StatelessWidget {
  const TodoWidget({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final TextEditingController todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 35,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Add to do list',
              ),
              controller: todo,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              context.read<TodoCubit>().add(
                title: TodoModels(
                  title: todo.text.trim(),
                ),
              );
              todo.clear();
            },
            child: Container(
              alignment: Alignment.center,
              height: 35,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Text(
                'add',
              ),
            ),
          )
        ],
      ),
    );
  }
}
