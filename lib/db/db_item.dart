import 'dart:async';
import 'package:compre_certo/db/db_creator.dart';
import 'package:compre_certo/models/itemModel.dart';
import 'package:sqflite/sqflite.dart';

class DBItem{
  DBCreator instance = DBCreator.instance;

  static final tableItem = "item_padrao";
  static final columnId = "_id";
  static final columnNome = "nome";
  static final columnQuantidade = "quantidade";

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

  deleteAllItems() async {
    final Database db = await instance.database;
    db.rawDelete("DELETE * FROM $tableItem");
  }

  Future<int> queryLastId() async {
    final Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.query(tableItem, orderBy: "$columnId DESC"));
  }

  Future<List<Item>> queryAllRows() async {
    final Database db = await instance.database;
    var res = await db.query(tableItem);
    List<Item> list =
        res.isNotEmpty ? res.map((i) => Item.fromJson(i)).toList() : null;
    return list;
  }
}