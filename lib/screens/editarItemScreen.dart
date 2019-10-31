import 'package:compre_certo/db/dbProvider.dart';
import 'package:compre_certo/models/itemPadraoModel.dart';
import 'package:flutter/material.dart';
import 'package:compre_certo/data/dados.dart';

class EditarItemScreen extends StatefulWidget {
  final ItemPadrao item;

  const EditarItemScreen({Key key, this.item}) : super(key: key);

  @override
  _EditarItemScreenState createState() => _EditarItemScreenState();
}

class _EditarItemScreenState extends State<EditarItemScreen> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController _itemController = TextEditingController();
  TextEditingController _qtdController = TextEditingController();
  FocusNode _nodeItem = FocusNode();
  FocusNode _nodeQtd = FocusNode();
  DBProvider db = DBProvider.instance;
  int currentUnidIndex = 0;

  @override
  void initState() {
    super.initState();
    _itemController.text = widget.item.nome;
    _qtdController.text = widget.item.quantidade.toString();
    currentUnidIndex = widget.item.medida;
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
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * .75,
              width: MediaQuery.of(context).size.width * .9,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60),
                  )),
              padding: const EdgeInsets.only(
                  top: 30, bottom: 20, left: 20, right: 20),
              child: Stack(children: <Widget>[
                Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                    Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.5),
                                    offset: Offset(0.0, 5.0),
                                    blurRadius: 5.0)
                              ]),
                          child: Center(
                              child:
                                  const Icon(Icons.edit, color: Colors.blue))),
                      SizedBox(width: 10),
                      const Text("Editar Item",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              labelText: "Item",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                          controller: _itemController,
                          focusNode: _nodeItem,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).requestFocus(_nodeQtd),
                          validator: (value) {
                            if (value.isEmpty ||
                                value == "" ||
                                value.length < 2) {
                              FocusScope.of(context).requestFocus(_nodeItem);
                              return "Insira um item válido";
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                labelText: "Quantidade",
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
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
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text("Medida",
                            style: TextStyle(color: Colors.white)),
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
                      OutlineButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          borderSide: BorderSide(color: Colors.white),
                          child: const Text("Cancelar",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.white,
                        child: const Text("Confirmar",
                            style: TextStyle(color: Colors.blue)),
                        onPressed: () {
                          if (_form.currentState.validate()) {
                            var item = ItemPadrao();
                            item.id = widget.item.id;
                            item.nome = _itemController.text
                                    .substring(0, 1)
                                    .toUpperCase() +
                                _itemController.text.substring(1);
                            item.quantidade = int.parse(_qtdController.text);
                            item.medida = currentUnidIndex;
                            db.updateItem(item);
                            Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  )
                ]),
              ]),
            ),
          ),
        ));
  }
}
