import 'package:flutter/material.dart';

class HistoricoScreen extends StatefulWidget {
  @override
  _HistoricoScreenState createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Histórico de Compras",
            style: TextStyle(
                color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.blue),
          centerTitle: true,
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
                            BorderRadius.only(bottomLeft: Radius.circular(60))),
                    child: Container())),
            SizedBox(height: 8)
          ])
        ])));
  }
}
