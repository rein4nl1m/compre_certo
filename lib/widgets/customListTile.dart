import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  final String title;

  const CustomListTile({Key key, this.title}) : super(key: key);

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      trailing: Icon(Icons.check_box),
    );
  }
}
