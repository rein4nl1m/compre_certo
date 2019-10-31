import 'dart:io';
import 'dart:async';
import 'package:compre_certo/models/itemListaModel.dart';
import 'package:compre_certo/models/itemPadraoModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final _databaseName = "CompreCertoDB.db";
  static final _databaseVersion = 1;

  static final tableItem = "item_padrao";
  static final listaCompras = "lista_compras";
  static final historicoCompras = "historico_compras";

  static final columnId = "_id";
  static final columnNome = "nome";
  static final columnQuantidade = "quantidade";
  static final columnMedida = "medida";
  static final columnVlrUnit = "vlr_unit";
  static final columnItemPadrao = "item_padrao";
  static final columnDtCompra = "dt_compra";
  static final columnItensCompra = "itens_compra";
  static final columnTotalCompra = "total_compra";

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
          $columnMedida INTEGER NOT NULL,
          UNIQUE($columnNome)
        );

        CREATE TABLE $listaCompras (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnQuantidade INTEGER NOT NULL,
          $columnMedida INTEGER NOT NULL,
          $columnVlrUnit DOUBLE NOT NULL,
          $columnItemPadrao TEXT NOT NULL
        );

        CREATE TABLE $historicoCompras (
          $columnDtCompra TEXT PRIMARY KEY,
          $columnItensCompra TEXT NOT NULL,
          $columnTotalCompra DOUBLE NOT NULL,
          UNIQUE($columnDtCompra)
        );
    ''');
  }

  Future<int> insertItem(ItemPadrao item) async {
    final Database db = await instance.database;
    return db.insert(tableItem, item.toJson());
  }

  updateItem(ItemPadrao item) async {
    final Database db = await instance.database;
    return db.update(tableItem, item.toJson(),
        where: '$columnId = ?', whereArgs: [item.id]);
  }

  deleteItem(int id) async {
    final Database db = await instance.database;
    return db.delete(tableItem, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> countItens() async {
    final Database db = await instance.database;
    int count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tableItem"));
    return count;
  }

  deleteAllItens() async {
    final Database db = await instance.database;
    db.delete(tableItem);
  }

  Future<List<ItemPadrao>> queryAllRowsItens() async {
    final Database db = await instance.database;
    var res = await db.query(tableItem, orderBy: "$columnNome");
    List<ItemPadrao> list =
        res.isNotEmpty ? res.map((i) => ItemPadrao.fromJson(i)).toList() : null;
    return list;
  }

  Future<List<ItemLista>> queryAllRowsCompras() async {
    final Database db = await instance.database;
    var res = await db.query(tableItem, orderBy: "$columnNome");
    List<ItemLista> list =
        res.isNotEmpty ? res.map((i) => ItemLista.fromJson(i)).toList() : null;
    return list;
  }
}
