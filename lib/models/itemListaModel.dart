import 'dart:convert';

ItemLista itemFromJson(String str) {
  final jsonData = jsonDecode(str);
  return ItemLista.fromJson(jsonData);
}

String itemToJson(ItemLista data) {
  final dyn = data.toJson();
  return jsonEncode(dyn);
}

class ItemLista {
  int id;
  int quantidade;
  int medida;
  double vlrUnit;
  String itemPadrao;

  ItemLista(
      {this.id, this.quantidade, this.medida, this.vlrUnit, this.itemPadrao});

  factory ItemLista.fromJson(Map<String, dynamic> json) => ItemLista(
      id: json["_id"],
      quantidade: json["quantidade"],
      medida: json["medida"],
      vlrUnit: json["vlr_unit"],
      itemPadrao: json["item_padrao"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "quantidade": quantidade,
        "medida": medida,
        "vlr_unit": vlrUnit,
        "item_padrao": itemPadrao
      };
}
