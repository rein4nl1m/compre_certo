import 'package:flutter/material.dart';

class NovoItemAlert extends StatefulWidget {
  @override
  _NovoItemAlertState createState() => _NovoItemAlertState();
}

class _NovoItemAlertState extends State<NovoItemAlert> {
  
  TextEditingController _itemController = TextEditingController();
  TextEditingController _qtdController = TextEditingController();

  @override
  void dispose() {
    _itemController.dispose();
    _qtdController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Insira o Novo Item: ",
        style: TextStyle(
            color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: "Item"),
                      controller: _itemController
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Quantidade"),
                      controller: _qtdController
                    )
                  ],
                ),
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
          child: const Text("Incluir", style: TextStyle(color: Colors.white)),
          onPressed: () {},
        )
      ],
    );
  }
}
