import 'package:compre_certo/widgets/customListTile.dart';
import 'package:compre_certo/widgets/novoItemAlert.dart';
import 'package:flutter/material.dart';

class ItensPadraoScreen extends StatefulWidget {
  @override
  _ItensPadraoScreenState createState() => _ItensPadraoScreenState();
}

class _ItensPadraoScreenState extends State<ItensPadraoScreen> {
  final List<String> itens = <String>[
    'Item 1',
    'Item 2',
    'Item 3',
    "Item 4",
    "Item 5",
    'Item 6',
    'Item 7',
    'Item 8',
    "Item 9",
    "Item 10",
    'Item 11',
    'Item 12',
    'Item 13',
    "Item 14",
    "Item 15",
    'Item 16',
    'Item 17',
    'Item 18',
    "Item 19",
    "Item 20",
  ];

  @override
  Widget build(BuildContext context) {
    void showAlertDialog() {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) => NovoItemAlert()); /* AlertDialog(
                title: const Text(
                  "Insira o Novo Item: ",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
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
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: "Quantidade"),
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
                      child: const Text("Cancelar",
                          style: TextStyle(color: Colors.blue)),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  RaisedButton(
                    color: Colors.blue,
                    child: const Text("Incluir",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                  )
                ],
              )); */
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          print("Back");
                        },
                      ),
                      Text(
                        "Itens Padrão",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.info,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          print("Add");
                        },
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(top: 20, left: 20),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(60))),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.only(bottom: 5),
                        itemCount: itens.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomListTile(
                            title: itens[index],
                          );
                        },
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
      endDrawer: Drawer(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        icon: const Icon(Icons.add, color: Colors.blue),
        label: const Text("Novo Item", style: TextStyle(color: Colors.blue)),
        onPressed: showAlertDialog,
      ),
    );
  }
}
