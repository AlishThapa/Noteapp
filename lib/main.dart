import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/screens/main_screen/main_screen.dart';
import 'package:noteapp/screens/note/note_bloc/note_bloc.dart';
import 'package:noteapp/screens/todo/db/database_service_todoApp.dart';
import 'package:noteapp/screens/todo/todo_bloc/todo_bloc.dart';
import 'Bloc/tab.dart';
import 'Screens/note/db/database_service_noteapp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseService().connectDb();
  DatabaseTodoService().connectDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NoteAppCubit()),
        BlocProvider(create: (context) => TodoCubit()),
        BlocProvider(create: (context) => TabCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
