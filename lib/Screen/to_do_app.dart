import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/todo.dart';
import '../Models/todo_model.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController todo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, List<TodoModels>>(
      builder: (context, state) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                leading: Checkbox(
                  value: state[index].isChecked,
                  onChanged: ( bool? value) {
                    context.read<TodoCubit>().updateTodo(
                      title: state[index].copyWith(isChecked: value),
                      i: index,
                    );
                  },
                ),
                title: Text(state[index].title),
                trailing: GestureDetector(
                  child: const Icon(Icons.delete_outline),
                  onTap: () => context.read<TodoCubit>().delete(i: index),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
