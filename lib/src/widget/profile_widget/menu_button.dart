import 'package:attendance_application/src/widget/profile_widget/logout_dialog.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  void choiceAction(String choice) {
    choice == 'logout'?
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return LogoutDialog();
        }
    ):
    null;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        itemBuilder: (BuildContext context) => [
          PopupMenuItem<String>(
              value: 'logout',
              child: Text('Logout')
          )
        ],
        onSelected: choiceAction,
    );
  }
}
