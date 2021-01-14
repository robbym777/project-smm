import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;

  Button(this.title);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {

      },
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16
        ),
      ),
      padding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
      ),
      color: Colors.red,
      textColor: Colors.white,
    );
  }
}
