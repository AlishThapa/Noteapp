import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'db/database_service_todoApp.dart';
import 'todo_bloc/todo_bloc.dart';
import 'models/todo_model.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController todo = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TodoCubit>().add();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, List<TodoModels>>(
      builder: (context, state) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: state[index].isChecked,
                      onChanged: (bool? value) {
                        context.read<TodoCubit>().updateTodo(
                          title: state[index].copyWith(isChecked: value),
                          i: index,
                        );
                      },
                    ),
                    title: Text(state[index].todo),
                    trailing: GestureDetector(
                      child: const Icon(Icons.delete_outline),
                      onTap: () {
                       DatabaseTodoService().deleteTodo(state[index].id);
                        context.read<TodoCubit>().delete(i: index);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
