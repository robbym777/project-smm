import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_event.dart';
import 'package:attendance_application/src/utils/pop_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class SubmitAttendIn extends StatelessWidget {
  final String employeeId;

  SubmitAttendIn({this.employeeId});

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      onPressed: () async {
        Navigator.of(context).pop();
        PopDialog.showProcessDialog(context);
        context.bloc<EmployeeBlocService>().add(SubmitAttendance(employeeId: employeeId, status: 'IN'));
      },
      color: Colors.green,
      icon: Icon(Icons.input),
      label: Text('Masuk'),
    );
  }
}
