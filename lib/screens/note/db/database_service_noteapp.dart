import 'package:noteapp/screens/note/db/db_modals/db_modal.dart';
import 'package:noteapp/screens/note/models/note_list.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  Future<Database> connectDb() async {
    var database = await openDatabase(join(await getDatabasesPath(), 'note.db'), version: 1, onCreate: (db, version) {
      db.execute(
        'CREATE TABLE tableNote(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT )',
        // 'CREATE TABLE noteTable(id INTEGER PRIMARY KEY, title TEXT, description TEXT'
      );
    }, onConfigure: onConfigure);
    return database;
  }

  onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  create(DatabaseModel databaseModel) async {
    final db = await DatabaseService().connectDb();
    await db.insert(
      'tableNote',
      databaseModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NoteModel>> readNote() async {
    final db = await DatabaseService().connectDb();
    var dbRead = await db.query('tableNote');
    return List.generate(
      dbRead.length,
      (index) => NoteModel(
        title: dbRead[index]['title'] as String,
        description: dbRead[index]['description'] as String,
        id: dbRead[index]['id'] as int,
      ),
    );
  }

  delete(int id) async {
    final db = await DatabaseService().connectDb();
    await db.delete(
      'tableNote',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
