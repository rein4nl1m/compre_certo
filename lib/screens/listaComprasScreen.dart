import 'package:flutter/material.dart';

class ListaComprasScreen extends StatefulWidget {
  @override
  _ListaComprasScreenState createState() => _ListaComprasScreenState();
}

class _ListaComprasScreenState extends State<ListaComprasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Lista de Compras",
            style: TextStyle(
                color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.blue),
          centerTitle: true,
          /* actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: (){},
          ),
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: (){},
          )
        ], */
        ),
        body: SafeArea(
            child: Stack(children: <Widget>[
          Column(children: <Widget>[
            Expanded(
                child: Container(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(60))),
                    child: Container()))
          ])
        ])));
  }
}
