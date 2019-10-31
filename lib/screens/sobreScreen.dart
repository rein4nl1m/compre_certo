import 'package:flutter/material.dart';

class SobreScreen extends StatefulWidget {
  @override
  _SobreScreenState createState() => _SobreScreenState();
}

class _SobreScreenState extends State<SobreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Sobre o Appp",
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
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(60))),
                    child: Container())),
            SizedBox(height: 8)
          ])
        ])));
  }
}
