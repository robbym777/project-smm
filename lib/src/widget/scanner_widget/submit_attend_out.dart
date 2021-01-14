import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_event.dart';
import 'package:attendance_application/src/utils/pop_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class SubmitAttendOut extends StatelessWidget {
  final String employeeId;

  SubmitAttendOut({this.employeeId});

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      onPressed: () async {
        Navigator.of(context).pop();
        PopDialog.showProcessDialog(context);
        context.bloc<EmployeeBlocService>().add(SubmitAttendance(employeeId: employeeId, status: 'OUT'));
      },
      color: Colors.red,
      icon: Icon(Icons.input),
      label: Text('Keluar'),
    );
  }
}
