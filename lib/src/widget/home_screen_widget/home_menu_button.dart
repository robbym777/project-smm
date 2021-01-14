import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onClick;

  MenuButton({this.label, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onClick,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 30,),
          Text(label)
        ],
      ),
      elevation: 10,
      color: Theme.of(context).secondaryHeaderColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
