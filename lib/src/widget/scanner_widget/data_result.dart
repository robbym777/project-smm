import 'package:flutter/material.dart';

class DataResult extends StatelessWidget {
  final String title;
  final String value;

  DataResult({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(flex: 1, child: Text(
              title,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))),
            SizedBox(width: 10),
            Expanded(flex: 2, child: Text(value)),
          ],
        ),
        Divider(),
      ],
    );
  }
}
