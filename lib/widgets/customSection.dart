import 'package:flutter/material.dart';

class CustomSection extends StatelessWidget {
  final String title;
  final IconData iconData;
  final PageRoute route;

  const CustomSection({Key key, this.title, this.iconData, this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(route);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: 130,
        height: 130,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Icon(iconData, size: 70, color: Colors.blue),
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
