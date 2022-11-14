import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/*
Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'filter.db');
  return openDatabase(path, version: 1, onCreate: (db, version) {
    db.execute(tabela)
  });
}
*/

class DatabaseConection {
  setDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'db_todolist');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database database, int version) async {
      await database.execute(
          'CREATE TABLE filters (id INTEGER PRIMARY KEY, title TEXT, description TEXT)');

      await database.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT)");
    });
    return database;
  }
}
