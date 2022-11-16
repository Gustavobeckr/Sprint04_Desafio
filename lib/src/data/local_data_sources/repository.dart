import 'package:sqflite/sqflite.dart';
import 'package:todo_list/src/data/local_data_sources/database_connection.dart';

class Repository {
  static final DatabaseConection _databaseConection = DatabaseConection();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _databaseConection.getDatabase();

    return _database;
  }

  Future insertData(table, data) async {
    final connection = await database;

    return await connection!.insert(table, data);
  }

  Future readData(table) async {
    final connection = await database;

    return await connection!.query(table);
  }

  Future readDataById(table, itemId) async {
    final connection = await database;
    return await connection!.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  Future editData(table, data) async {
    final connection = await database;
    return await connection!
        .update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  Future deleteData(table, itemId) async {
    final connection = await database;
    return await connection!.rawDelete('DELETE FROM $table WHERE id = $itemId');
  }

  Future readDateByFilter(table, filter, filterValue) async {
    final connection = await database;
    return await connection!
        .query(table, where: '$filter', whereArgs: [filterValue]);
  }
}
