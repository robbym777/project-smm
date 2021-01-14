import 'package:flutter/material.dart';

class ProfileData extends StatelessWidget {
  final String title;
  final String data;

  ProfileData({this.title, this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54)
                ,
              ),
            ),
            SizedBox(width: 5),
            Expanded(flex: 3, child: Text(data))
          ],
        ),
        Divider()
      ],
    );
  }
}
