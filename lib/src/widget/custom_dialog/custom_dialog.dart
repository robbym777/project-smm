import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final Color color;
  final String title;
  final String text;

  CustomDialog({this.color, this.title, this.text});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      title: Text(title, style: TextStyle(color: color)),
      backgroundColor:  Theme.of(context).secondaryHeaderColor,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            Text(text, textAlign: TextAlign.center),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Theme.of(context).primaryColor,
              child: Text('OK', style: TextStyle(color: Theme.of(context).secondaryHeaderColor)),
            )
          ],
        )
      ],
    );
  }
}
