import 'package:sqflite/sqflite.dart';
import '../todo/models/todo_model.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;
  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> insertRaw(String insert) async {
    final db = await instance.database;
    await db.rawInsert('$insert');
  }

  Future<List<Map>> rawQuery(String query) async {
    final db = await instance.database;
    List<Map> list = await db.rawQuery('$query');

    return list;
  }

  Future<void> rawUpdate(String query) async {
    final db = await instance.database;
    await db.rawUpdate('$query');
  }

  Future<void> rawDelete(String query) async {
    final db = await instance.database;
    await db.rawDelete('$query');
  }
}

Future _createDB(Database db, int version) async {
  await db.execute(
      'CREATE TABLE $tableToDoToday (id INTEGER PRIMARY KEY, ${ToDoFields.name} TEXT, ${ToDoFields.time} TEXT, ${ToDoFields.isChecked} BOOLEAN)');
  await db.execute(
      'CREATE TABLE $tableToDoTomorrow (id INTEGER PRIMARY KEY, ${ToDoFields.name} TEXT, ${ToDoFields.time} TEXT, ${ToDoFields.isChecked} BOOLEAN)');
}
