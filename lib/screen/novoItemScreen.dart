import 'package:compre_certo/db/dbProvider.dart';
import 'package:compre_certo/models/itemModel.dart';
import 'package:flutter/material.dart';

class NovoItemScreen extends StatefulWidget {
  @override
  _NovoItemScreenState createState() => _NovoItemScreenState();
}

class _NovoItemScreenState extends State<NovoItemScreen> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController _itemController = TextEditingController();
  TextEditingController _qtdController = TextEditingController();
  FocusNode _nodeItem = FocusNode();
  FocusNode _nodeQtd = FocusNode();
  DBProvider db = DBProvider.instance;
  int currentUnidIndex = 0;
  List<String> unidList = ["Un", "Kg"];

  @override
  Widget build(BuildContext context) {
    Widget unidItem(String size, bool isSelected, BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
              color: isSelected ? Colors.white : Color(0xFF525663),
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: isSelected
                        ? Colors.black.withOpacity(.5)
                        : Colors.black12,
                    offset: Offset(0.0, 10.0),
                    blurRadius: 10.0)
              ]),
          child: Center(
            child: Text(size, style: TextStyle(color: Colors.blue)),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * .7,
              width: MediaQuery.of(context).size.width * .7,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60),
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60))),
              padding:
                  EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text("Novo Item",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold)),
                    SingleChildScrollView(
                      child: Form(
                        key: _form,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: "Item"),
                              controller: _itemController,
                              focusNode: _nodeItem,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).requestFocus(_nodeQtd),
                              validator: (value) {
                                if (value.isEmpty ||
                                    value == "" ||
                                    value.length < 2) {
                                  FocusScope.of(context)
                                      .requestFocus(_nodeItem);
                                  return "Insira um item válido";
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Quantidade",
                                ),
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
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Medida"),
                          SizedBox(height: 5),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: unidList.map((item) {
                                var index = unidList.indexOf(item);
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentUnidIndex = index;
                                    });
                                  },
                                  child: unidItem(
                                      item, index == currentUnidIndex, context),
                                );
                              }).toList())
                        ]),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                            child: const Text("Cancelar",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        RaisedButton(
                          color: Colors.white,
                          child: const Text("Incluir",
                              style: TextStyle(color: Colors.blue)),
                          onPressed: () {
                            if (_form.currentState.validate()) {
                              var item = Item();
                              item.nome = _itemController.text
                                      .substring(0, 1)
                                      .toUpperCase() +
                                  _itemController.text.substring(1);
                              item.quantidade = int.parse(_qtdController.text);
                              db.insertItem(item);
                              setState(() {});
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    )
                  ]),
            ),
          ),
          Positioned(
              top: 50,
              left: 30,
              child: Material(
                borderRadius: BorderRadius.circular(80),
                elevation: 12,
                child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(80)),
                    child: Center(
                        child: Icon(Icons.add,
                            color: Colors.blue, size: 40))),
              ))
        ],
      ),
    );
  }
}
