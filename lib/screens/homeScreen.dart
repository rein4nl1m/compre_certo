import 'package:compre_certo/screens/historicoScreen.dart';
import 'package:compre_certo/screens/itensPadraoScreen.dart';
import 'package:compre_certo/screens/listaComprasScreen.dart';
import 'package:compre_certo/screens/sobreScreen.dart';
import 'package:compre_certo/widgets/customSection.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text("Compre Certo!",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0),
        body: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .97,
              height: MediaQuery.of(context).size.height * .82,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(60)),
              padding: EdgeInsets.all(30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CustomSection(
                              title: "Itens Padrão",
                              iconData: Icons.add_box,
                              route: MaterialPageRoute(
                                  builder: (context) => ItensPadraoScreen())),
                          SizedBox(width: 5),
                          CustomSection(
                              title: "Lista de Compras",
                              iconData: Icons.list,
                              route: MaterialPageRoute(
                                  builder: (context) => ListaComprasScreen())),
                        ]),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CustomSection(
                              iconData: Icons.history,
                              title: "Histórico de Compras",
                              route: MaterialPageRoute(
                                  builder: (context) => HistoricoScreen())),
                          SizedBox(width: 5),
                          CustomSection(
                              iconData: Icons.info,
                              title: "Sobre o App",
                              route: MaterialPageRoute(
                                  builder: (context) => SobreScreen())),
                        ]),
                    SizedBox(height: 20)
                  ]),
            ),
          ),
        ));
  }
}
