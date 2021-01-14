import 'package:attendance_application/src/services/db_service/db_service.dart';
import 'package:attendance_application/src/services/google_auth.dart';
import 'package:attendance_application/src/utils/pop_dialog.dart';
import 'package:attendance_application/src/utils/storage_io.dart';
import 'package:attendance_application/src/screens/login_screen.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(20),
            child: Center(child: Text('Logout?', style: TextStyle(fontSize: 16)))
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            OutlineButton(
              child: Text('Tidak'),
              borderSide: BorderSide(color: Colors.red),
              textColor: Colors.red,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            RaisedButton(
              child: Text('Ya', style: TextStyle(color: Colors.white)),
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                PopDialog.showLoadingDialog(context);
                await DbService().deleteProfile();
                await StorageIO().deleteStorage();
                await GoogleAuth().signOutGoogle().then((status) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginScreen.ROUTE_NAME,
                      ModalRoute.withName(LoginScreen.ROUTE_NAME)
                  );
                }).catchError((err) {
                  print(err);
                  Navigator.pop(context);
                });
              },
            )
          ],
        )
      ],
    );
  }
}
