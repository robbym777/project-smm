import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String title;
  final bool isPassword;
  final IconData icons;

  EntryField(this.title, this.isPassword, this.icons);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey
            ),
            borderRadius: BorderRadius.circular(25),
            color: Colors.white30
        ),
        child: TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            icon: Container(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                  icons,
              ),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(right: 20),
            hintText: title,
          ),
        ),
      ),
    );
  }
}
