import 'dart:convert';

ItemPadrao itemFromJson(String str) {
  final jsonData = jsonDecode(str);
  return ItemPadrao.fromJson(jsonData);
}

String itemToJson(ItemPadrao data) {
  final dyn = data.toJson();
  return jsonEncode(dyn);
}

class ItemPadrao {
  int id;
  String nome;
  int quantidade;
  int medida;

  ItemPadrao({this.id, this.nome, this.quantidade, this.medida});

  factory ItemPadrao.fromJson(Map<String, dynamic> json) => ItemPadrao(
      id: json["_id"],
      nome: json["nome"],
      quantidade: json["quantidade"],
      medida: json["medida"]);

  Map<String, dynamic> toJson() =>
      {"_id": id, "nome": nome, "quantidade": quantidade, "medida": medida};
}
