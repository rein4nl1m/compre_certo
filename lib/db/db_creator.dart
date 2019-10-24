import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBCreator {
  static final _databaseName = "CheckCompraDB.db";
  static final _databaseVersion = 1;

  DBCreator._privateConstructor();
  static final DBCreator instance = DBCreator._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  _initDB() async {
    Directory documentsDiretory = await getApplicationDocumentsDirectory();
    String path = join(documentsDiretory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onOpen: (database) {}, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE item_padrao (
          _id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          quantidade INTEGER NOT NULL,
          UNIQUE(nome)
        )
    ''');
  }
}
