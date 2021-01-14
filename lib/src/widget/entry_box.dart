import 'package:flutter/material.dart';
import 'package:attendance_application/src/widget/entry_field.dart';
import 'package:attendance_application/src/widget/button.dart';

class EntryBox extends StatelessWidget {
  final String page;
  final List entryFields;

  EntryBox({this.page, this.entryFields});

  Widget _inputDataWidget() {
    return Column(
      children: entryFields.map((data) {
        return EntryField(data['title'], data['isPassword'] ,data['icon']);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _inputDataWidget(),
        Button(page),
        InkWell(
          child: page == 'LOGIN'?
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Forgot password?',
                style: TextStyle(
                    color: Colors.red
                ),
              )
          ) : Container()
        ),
      ],
    );
  }
}
