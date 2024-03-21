import 'package:database/sqlLigte/Model/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  final String dataBaseName = "users.db";
  Database? database;
  Future<Database> initializeDB() async {
    print("init dab.....");
    if (database != null) {
      print("allready redy");
      return database!;
    } else {
      String path = await getDatabasesPath();
      return openDatabase(join(path, "database.db"),
          onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL, email TEXT NOT NULL, qlf TEXT NOT NULL)");
      }, version: 1);
    }
  }

  /// get all db
  //get all Projects
  Future getAllProjects() async {
    final Database db = await initializeDB();
    return await db.query("users");
  }

  /// insert data into db
  Future<int> createItem(User reqdata) async {
    final Database db = await initializeDB();
    final id = await db.insert('users', reqdata.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  /// get data from table
  Future<List<User>> getItems() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query("users");
    return queryResult.map((e) => User.fromMap(e)).toList();
  }

  /// Delete  data from a table in Sqlite

  Future<void> deleteItem(String id) async {
    final db = await initializeDB();
    try {
      await db.delete("User", where: "id=?", whereArgs: [id]);
    } catch (e) {
      debugPrint("Something went wrong when deleting anitem: $e");
    }
  }
}
