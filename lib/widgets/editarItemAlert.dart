import 'package:compre_certo/db/dbProvider.dart';
import 'package:compre_certo/models/itemModel.dart';
import 'package:flutter/material.dart';

class EditarItemAlert extends StatefulWidget {
  final Item item;

  const EditarItemAlert({Key key, this.item}) : super(key: key);

  @override
  _EditarItemAlertState createState() => _EditarItemAlertState();
}

class _EditarItemAlertState extends State<EditarItemAlert> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController _itemController = TextEditingController();
  TextEditingController _qtdController = TextEditingController();
  FocusNode _nodeItem = FocusNode();
  FocusNode _nodeQtd = FocusNode();
  DBProvider db = DBProvider.instance;

  @override
  void initState() {
    super.initState();
    _itemController.text = widget.item.nome;
    _qtdController.text = widget.item.quantidade.toString();
  }

  @override
  void dispose() {
    _itemController.dispose();
    _qtdController.dispose();
    _nodeItem.dispose();
    _nodeQtd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Editar Item: ",
        style: TextStyle(
            color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        height: 180,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Item", icon: Icon(Icons.add_box)),
                  controller: _itemController,
                  focusNode: _nodeItem,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_nodeQtd),
                  validator: (value) {
                    if (value.isEmpty || value == "" || value.length < 2) {
                      FocusScope.of(context).requestFocus(_nodeItem);
                      return "Insira um item válido";
                    }
                  },
                ),
                TextFormField(
                    decoration: InputDecoration(
                        labelText: "Quantidade",
                        icon: Icon(Icons.confirmation_number)),
                    controller: _qtdController,
                    keyboardType: TextInputType.number,
                    focusNode: _nodeQtd,
                    validator: (value) {
                      if (value.isEmpty || int.parse(value) == 0) {
                        return "Insira uma quantidade válida";
                      }
                    })
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            child: const Text("Cancelar", style: TextStyle(color: Colors.blue)),
            onPressed: () {
              Navigator.pop(context);
            }),
        RaisedButton(
          color: Colors.blue,
          child: const Text("Confirmar", style: TextStyle(color: Colors.white)),
          onPressed: () async {
            if (_form.currentState.validate()) {
              var item = Item();
              item.id = widget.item.id;
              item.nome = _itemController.text;
              item.quantidade = int.parse(_qtdController.text);
              db.updateItem(item);
              setState(() {});
              Navigator.pop(context);
            }
          },
        )
      ],
    );
  }
}
