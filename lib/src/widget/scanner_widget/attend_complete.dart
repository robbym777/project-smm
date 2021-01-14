import 'package:flutter/material.dart';

class AttendComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      onPressed: null,
      icon: Icon(Icons.check_circle_outline),
      label: Text('Absensi hari ini selesai'),
    );
  }
}
