import 'package:sqflite/sqflite.dart';
import 'package:todo_list/src/data/local_data_sources/database_connection.dart';

class Repository {
  final DatabaseConection _databaseConection = DatabaseConection();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _databaseConection.setDatabase();

    return _database;
  }

  insertData(table, data) async {
    var connection = await database;
    return await connection!.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return await connection!.query(table);
  }

  readDataById(table, itemId) async {
    var connection = await database;
    return await connection!.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  editData(table, data) async {
    var connection = await database;
    return await connection!
        .update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  deleteData(table, itemId) async {
    var connection = await database;
    return await connection!.rawDelete('DELETE FROM $table WHERE id = $itemId');
  }
}
