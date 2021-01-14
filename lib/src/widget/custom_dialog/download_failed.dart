import 'package:attendance_application/src/screens/main_screen.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadFailed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<EmployeeBlocService>(context),
      listener: (context, blocService) {
        if (blocService is Success) {
          print('======Download Success======');
          Navigator.of(context).pushReplacementNamed(MainScreen.ROUTE_NAME);
        }
      },
      child: SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        title: Text('Data gagal diunduh', style: TextStyle(color: Colors.red)),
        backgroundColor:  Theme.of(context).secondaryHeaderColor,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20),
              Text('Tidak dapat terhubung ke server, mohon periksa koneksi internet anda', textAlign: TextAlign.center),
              SizedBox(height: 20),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  context.bloc<EmployeeBlocService>().add(SetEmployeeProfile());
                },
                color: Theme.of(context).primaryColor,
                child: Text('Unduh ulang', style: TextStyle(color: Theme.of(context).secondaryHeaderColor)),
              )
            ],
          )
        ],
      ),
    );
  }
}
