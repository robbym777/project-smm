import 'package:attendance_application/src/models/employee_model.dart';
import 'package:flutter/material.dart';

class AddressRow extends StatelessWidget {
  final String title;
  final Address addressData;

  AddressRow({this.title, this.addressData});

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
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(addressData.street),
                  Text(addressData.village),
                  Text(addressData.district),
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
