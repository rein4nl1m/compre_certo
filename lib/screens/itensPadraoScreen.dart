import 'package:compre_certo/db/dbProvider.dart';
import 'package:compre_certo/models/itemPadraoModel.dart';
import 'package:compre_certo/screens/editarItemScreen.dart';
import 'package:compre_certo/screens/novoItemScreen.dart';
import 'package:compre_certo/widgets/infoAlert.dart';
import 'package:compre_certo/widgets/slideBackground.dart';
import 'package:flutter/material.dart';
import 'package:compre_certo/data/dados.dart';

class ItensPadraoScreen extends StatefulWidget {
  @override
  _ItensPadraoScreenState createState() => _ItensPadraoScreenState();
}

class _ItensPadraoScreenState extends State<ItensPadraoScreen> {
  DBProvider db = DBProvider.instance;
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void _showInfoAlert() {
      showDialog(context: context, builder: (_) => InfoAlert());
    }

    void showAlertExcluirTodos() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Deseja excluir todos os itens?"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                actions: <Widget>[
                  FlatButton(
                      child: Text("Não", style: TextStyle(color: Colors.red)),
                      onPressed: () => Navigator.pop(context)),
                  RaisedButton(
                    color: Colors.red,
                    child: Text("Sim", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.pop(context);
                      db.deleteAllItens();
                    },
                  )
                ],
              )).then((_) => setState(() {}));
    }

    verificaItens() async {
      int count = await db.countItens();
      if (count > 0) {
        showAlertExcluirTodos();
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    "Lista Vazia!",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  content: const Text(
                      "Não existem itens na lista para serem excluídos!"),
                  actions: <Widget>[
                    FlatButton(
                        child: const Text("Ok",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                ));
      }
    }

    Widget _customListTile(ItemPadrao item) {
      return Dismissible(
          key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
          background: SlideDeleteBackground(),
          secondaryBackground: SlideEditBackground(),
          child: Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black))),
            width: MediaQuery.of(context).size.width * .92,
            padding: EdgeInsets.only(left: 10),
            child: ListTile(
                contentPadding: EdgeInsets.only(top: 10),
                title: Text(item.nome,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Quantidade: ${item.quantidade}"),
                        Text("Medida: ${unidList[item.medida]}"),
                        SizedBox(width: 20)
                      ],
                    )
                  ],
                )),
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
                                    duration: Duration(milliseconds: 1500));

                                _scaffold.currentState.removeCurrentSnackBar();
                                _scaffold.currentState.showSnackBar(snack);
                              });
                            },
                          )
                        ],
                      ));
            } else {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditarItemScreen(item: item)))
                  .then((_) => setState(() {}));
            }
          });
    }

    return Scaffold(
        key: _scaffold,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Itens Padrão",
            style: TextStyle(
                color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.blue),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: _showInfoAlert,
            ),
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: verificaItens,
            )
          ],
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
                    child: FutureBuilder<List<ItemPadrao>>(
                        future: db.queryAllRowsItens(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<ItemPadrao>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.only(bottom: 5),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                ItemPadrao item = snapshot.data[index];
                                return _customListTile(item);
                              },
                            );
                          } else {
                            return Center(
                                child: Text("Insira um novo item!",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)));
                          }
                        })))
          ]),
          Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NovoItemScreen())),
                  child: Hero(
                      tag: "novoItem",
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60))),
                        width: 70,
                        height: 70,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child:
                            const Icon(Icons.add, color: Colors.blue, size: 40),
                      ))))
        ])));
  }
}
