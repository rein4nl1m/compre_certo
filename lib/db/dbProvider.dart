import 'dart:io';
import 'dart:async';
import 'package:compre_certo/models/itemModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final _databaseName = "CompreCertoDB.db";
  static final _databaseVersion = 1;

  static final tableItem = "item_padrao";

  static final columnId = "_id";
  static final columnNome = "nome";
  static final columnQuantidade = "quantidade";

  DBProvider._privateConstructor();
  static final DBProvider instance = DBProvider._privateConstructor();

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
        CREATE TABLE $tableItem (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnNome TEXT NOT NULL,
          $columnQuantidade INTEGER NOT NULL,
          UNIQUE($columnNome)
        )
    ''');
  }

  Future<int> insertItem(Item item) async {
    final Database db = await instance.database;
    return db.insert(tableItem, item.toJson());
  }
  

  updateItem(Item item) async {
    final Database db = await instance.database;
    return db.update(tableItem, item.toJson(),
        where: '$columnId = ?', whereArgs: [item.id]);
  }

  deleteItem(int id) async {
    final Database db = await instance.database;
    return db.delete(tableItem, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> countItems() async {
    final Database db = await instance.database;
    int count = Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM $tableItem"));
    return count;
  }

  deleteAllItems() async {
    final Database db = await instance.database;
    db.delete(tableItem);
  }

  Future<List<Item>> queryAllRows() async {
    final Database db = await instance.database;
    var res = await db.query(tableItem, orderBy: "$columnNome");
    List<Item> list =
        res.isNotEmpty ? res.map((i) => Item.fromJson(i)).toList() : null;
    return list;
  }
}
