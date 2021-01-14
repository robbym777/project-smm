import 'package:flutter/material.dart';

class CheckingData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  child: Image.asset('assets/img/icons/sinarmas-mining-logo.png')
              ),
              Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text('Checking authentication...'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
