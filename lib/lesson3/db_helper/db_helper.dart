import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';
import 'dart:io' as io;
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static const todo = 'todo';

  static Future<Database> database() async {
    sqfliteFfiInit();

    var databaseFactory = databaseFactoryFfi;
    final io.Directory appDocumentsDir =
        await getApplicationDocumentsDirectory();
    String dbPath = join(appDocumentsDir.path, "databases", "todo.db");
    print("************dbPath********");
    print(dbPath);
    var db = await databaseFactory.openDatabase(
      dbPath,
    );
    // return await openDatabase(
    //   join(dbPath, 'todo.db'),
    //   onCreate: (db, version) {
    //     db.execute("CREATE TABLE IF NOT EXISTS $todo(id TEXT PRIMARY KEY ,"
    //         " title TEXT,"
    //         " description TEXT,"
    //         " date TEXT)");
    //   },
    //   version: 1,
    // );
    await db.execute("CREATE TABLE IF NOT EXISTS $todo(id TEXT PRIMARY KEY ,"
        " title TEXT,"
        " description TEXT,"
        " date TEXT)");
    return db;
  }

  static Future selectAll(String table) async {
    final db = await DBHelper.database();
    //With out Query
    print("*************db.query(table)**********");
    print(db.query(table));
    return db.query(table);
    // with Query
    // return db.rawQuery("SELECT * FROM $todo");
  }

  static Future insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    return db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future update(
    String tableName,
    String columnName,
    String value,
    String id,
  ) async {
    final db = await DBHelper.database();

    return db.update(
      tableName,
      {'$columnName': value},
      where: 'id = ? ',
      whereArgs: [id],
    );
  }

  static Future deleteTable(String tableName) async {
    final db = await DBHelper.database();

    return db.rawQuery('DELETE FROM ${tableName}');
  }

  static Future deleteById(
    String tableName,
    String columnName,
    String id,
  ) async {
    final db = await DBHelper.database();

    return db.delete(
      tableName,
      where: '$columnName = ?',
      whereArgs: [id],
    );
  }
}
