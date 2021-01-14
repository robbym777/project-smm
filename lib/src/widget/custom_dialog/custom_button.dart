import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color color;
  final Function onClick;

  CustomButton({this.label, this.color, this.onClick});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onClick,
      color: color,
      child: Text(label, style: TextStyle(color: Theme.of(context).secondaryHeaderColor)),
    );
  }
}
