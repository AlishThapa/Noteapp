import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo_model.dart';
import 'db_todo_modals/db_todo_modals.dart';

class DatabaseTodoService {
  Future<Database> connectDb() async {
    var database = await openDatabase(join(await getDatabasesPath(), 'todo.db'), version: 1, onCreate: (
      db,
      version,
    ) {
      db.execute('CREATE TABLE tableTodo(id INTEGER PRIMARY KEY, todo TEXT)');
    }, onConfigure: onConfigure);
    if (database != null) {
      print('Database connected successfully ');
      return database;
    } else {
      print('Unable to connect to database ');
      return database;
    }
  }

  onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  create(DatabaseModelTodo databaseModelTodo) async {
    final db = await DatabaseTodoService().connectDb();
    await db.insert(
      'tableTodo',
      databaseModelTodo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TodoModels>> readTodo() async {
    final db = await DatabaseTodoService().connectDb();
    var dbReadTodo = await db.query('tableTodo');
    return List.generate(
      dbReadTodo.length,
      (index) => TodoModels(
        todo: dbReadTodo[index]['todo'] as String,
        id: dbReadTodo[index]['id'] as int,
      ),
    );
  }

  deleteTodo(int? id) async {
    final db = await DatabaseTodoService().connectDb();
    await db.delete(
      'tableTodo',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
