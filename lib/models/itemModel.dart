import 'dart:convert';

Item itemFromJson(String str) {
  final jsonData = jsonDecode(str);
  return Item.fromJson(jsonData);
}

String itemToJson(Item data) {
  final dyn = data.toJson();
  return jsonEncode(dyn);
}

class Item {
  int id;
  String nome;
  int quantidade;
  int medida;

  Item({this.id, this.nome, this.quantidade, this.medida});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"],
        nome: json["nome"],
        quantidade: json["quantidade"],
        medida: json["medida"]
      );

  Map<String, dynamic> toJson() =>
      {"_id": id, "nome": nome, "quantidade": quantidade, "medida": medida};
}