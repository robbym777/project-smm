import 'package:attendance_application/src/widget/google_auth_button.dart';
import 'package:attendance_application/src/widget/login_widget/login_header_style.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const ROUTE_NAME = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Colors.red,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              LoginHeaderStyle(),
//              LoginHeaderStyle2(),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                          child: Image.asset('assets/img/icons/sinarmas-mining-logo.png')
                      ),
                    ),
                    GoogleAuthButton(),
                    Expanded(
                        flex: 2,
                        child: SizedBox()
                    ),
//                    RaisedButton(
//                      onPressed: () async {
//                        await DbService().deleteDataBase();
//                      },
//                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
