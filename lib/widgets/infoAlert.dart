import 'package:flutter/material.dart';

class InfoAlert extends StatefulWidget {
  @override
  _InfoAlertState createState() => _InfoAlertState();
}

class _InfoAlertState extends State<InfoAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Itens Padrão",
        style: TextStyle(
            color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: RichText(  
        textAlign: TextAlign.center,
        text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 16),
            text: "Lista de ",
            children: <TextSpan>[
              TextSpan(
                  text: "Itens Padrão",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: " que será usada como base para gerar sua "),
              TextSpan(
                  text: "Lista de Compras",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: "!"),
            ]),
      ),
      actions: <Widget>[
        FlatButton(
            child: const Text("Ok",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18)),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );
  }
}