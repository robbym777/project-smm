import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomFilterTab extends StatefulWidget {
  final Function getAll;
  final Function pickDate;

  CustomFilterTab({this.getAll, this.pickDate});

  @override
  _CustomFilterTabState createState() => _CustomFilterTabState();
}

class _CustomFilterTabState extends State<CustomFilterTab> {
  DateTime chosenDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text('Filter'),
        OutlineButton(
          onPressed: () {
            widget.getAll();
            setState(() {
              chosenDate = null;
            });
          },
          child: Text('Semua'),
        ),
        OutlineButton(
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: chosenDate == null? DateTime.now():chosenDate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2050),
            ).then((onValue) {
              if (onValue != null) {
                widget.pickDate(onValue);
              }
              setState(() {
                chosenDate = onValue;
              });
            });
          },
          child: Text(chosenDate == null? 'Pilih tanggal':DateFormat('yyyy-MM-dd').format(chosenDate)),
        ),
      ],
    );
  }
}
