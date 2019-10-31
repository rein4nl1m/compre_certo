import 'package:flutter/material.dart';

class ButtonGeraLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Deseja gerar a lista a partir de qual base?",
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              elevation: 10,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  bottomLeft: Radius.circular(60)),
              child: InkWell(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      bottomLeft: Radius.circular(60)),
                  onTap: () {},
                  child: Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 75,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              bottomLeft: Radius.circular(60)),
                          color: Colors.blue[700]),
                      child: Text("Itens\nPadrão",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center))),
            ),
            Material(
              elevation: 10,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(60),
                  bottomRight: Radius.circular(60)),
              child: InkWell(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                    bottomRight: Radius.circular(60)),
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  width: 120,
                  height: 75,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(60),
                          bottomRight: Radius.circular(60)),
                      color: Colors.blue[700]),
                  child: Text("Média\ndo\nHistórico",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
