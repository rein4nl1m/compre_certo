import 'package:compre_certo/screen/itensPadraoScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compre Certo!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ItensPadraoScreen()
    );
  }
}