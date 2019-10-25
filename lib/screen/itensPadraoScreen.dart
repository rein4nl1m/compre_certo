import 'package:compre_certo/db/dbProvider.dart';
import 'package:compre_certo/models/itemModel.dart';
import 'package:compre_certo/widgets/editarItemAlert.dart';
import 'package:compre_certo/widgets/infoAlert.dart';
import 'package:compre_certo/widgets/novoItemAlert.dart';
import 'package:compre_certo/widgets/slideBackground.dart';
import 'package:flutter/material.dart';

class ItensPadraoScreen extends StatefulWidget {
  @override
  _ItensPadraoScreenState createState() => _ItensPadraoScreenState();
}

class _ItensPadraoScreenState extends State<ItensPadraoScreen> {
  DBProvider db = DBProvider.instance;
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void showAlertDialog() {
      showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => NovoItemAlert())
          .then((_) => setState(() {}));
    }

    void _showInfoAlert() {
      showDialog(context: context, builder: (_) => InfoAlert());
    }

    Widget _customListTile(Item item) {
      return Dismissible(
          key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
          background: SlideDeleteBackground(),
          secondaryBackground: SlideEditBackground(),
          child: ListTile(
            onTap: () => showDialog(
                context: context,
                builder: (context) => EditarItemAlert(item: item)),
            title:
                Text(item.nome, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Quantidade.: ${item.quantidade}"),
          ),
          confirmDismiss: (direction) {
            if (direction == DismissDirection.startToEnd) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Deseja excluir o item \"${item.nome}\"?"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        actions: <Widget>[
                          FlatButton(
                              child: Text("Não",
                                  style: TextStyle(color: Colors.red)),
                              onPressed: () => Navigator.pop(context)),
                          RaisedButton(
                            color: Colors.red,
                            child: Text("Sim",
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                db.deleteItem(item.id);

                                final snack = SnackBar(
                                    content:
                                        Text("Item \"${item.nome}\" removido!"),
                                    action: SnackBarAction(
                                      label: "Desfazer",
                                      onPressed: () {
                                        setState(() {
                                          db.insertItem(item);
                                        });
                                      },
                                    ),
                                    duration: Duration(seconds: 3));

                                _scaffold.currentState.removeCurrentSnackBar();
                                _scaffold.currentState.showSnackBar(snack);
                              });
                            },
                          )
                        ],
                      ));
            } else {
              showDialog(
                      context: context,
                      builder: (context) => EditarItemAlert(item: item))
                  .then((_) => setState(() {}));
            }
          });
    }

    return Scaffold(
      key: _scaffold,
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
                        onPressed: _showInfoAlert,
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
                      child: FutureBuilder<List<Item>>(
                        future: db.queryAllRows(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Item>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.only(bottom: 5),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                Item item = snapshot.data[index];
                                return _customListTile(item);
                              },
                            );
                          } else {
                            return Center(
                                child: Text("Insira um novo item!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)));
                          }
                        },
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        icon: const Icon(Icons.add, color: Colors.blue),
        label: const Text("Novo Item", style: TextStyle(color: Colors.blue)),
        onPressed: showAlertDialog,
      ),
    );
  }
}
