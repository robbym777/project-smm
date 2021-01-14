import 'package:flutter/material.dart';

class BottomDialog extends StatelessWidget {
  final Widget message;

  BottomDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - 10,
          height: MediaQuery.of(context).size.height / 2,
          color: Colors.white,
          child: Scaffold(
            body: Container(
                padding: EdgeInsets.all(20),
                child: message
            ),
          ),
        ),
      ],
    );
  }
}
