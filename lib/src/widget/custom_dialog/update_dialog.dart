import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_event.dart';
import 'package:attendance_application/src/utils/pop_dialog.dart';
import 'package:attendance_application/src/widget/custom_dialog/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class UpdateDialog extends StatelessWidget {
  final String title;
  final String text;
  final bool isUpdate;

  UpdateDialog({this.title, this.text, this.isUpdate});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      title: Text(title, style: TextStyle(color: Colors.green), textAlign: TextAlign.center),
      backgroundColor:  Theme.of(context).secondaryHeaderColor,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            isUpdate
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CustomButton(
                        onClick: () {
                          Navigator.of(context).pop();

                          PopDialog.showProcessDialog(context);
                          context.bloc<EmployeeBlocService>().add(UpdateEmployee());
                        },
                        label: 'Perbarui sekarang',
                        color: Colors.green,
                      ),
                      CustomButton(
                        onClick: () {
                          Navigator.of(context).pop();
                        },
                        label: 'Perbarui nanti',
                        color: Colors.red,
                      )
                    ],
                  )
                : CustomButton(
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                    label: 'OK',
                    color: Colors.green,
                  )
          ],
        )
      ],
    );
  }
}
