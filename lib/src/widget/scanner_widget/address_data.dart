import 'package:attendance_application/src/models/employee_model.dart';
import 'package:flutter/material.dart';

class AddressData extends StatelessWidget {
  final String title;
  final Address addressData;

  AddressData({this.title, this.addressData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                title,
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(addressData.street + ','),
                  Text(addressData.village + ','),
                  Text(addressData.district + ','),
                  Text(addressData.province)
                ],
              ),
            )
          ],
        ),
        Divider()
      ],
    );
  }
}
