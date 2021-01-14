import 'dart:async';

import 'package:attendance_application/src/screens/main_screen.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_state.dart';

import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_state.dart';
import 'package:attendance_application/src/utils/pop_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: BlocProvider.of<OfflineBlocService>(context),
          listener: (context, blocService) {
            if (blocService is NoData) {
              print('======Downloading data from server======');
              context.bloc<EmployeeBlocService>().add(SetEmployeeProfile());
            }
            if (blocService is DataAlready) {
              print('======Data is already in local storage======');
              Timer(Duration(seconds: 2), () {
                Navigator.of(context).pushReplacementNamed(MainScreen.ROUTE_NAME);
              });
            }
            return Container();
          },
        ),
        BlocListener(
          bloc: BlocProvider.of<EmployeeBlocService>(context),
          listener: (context, blocService) {
            if (blocService is Success) {
              print('======Download Success======');
              Timer(Duration(seconds: 2), () {
                Navigator.of(context).pushReplacementNamed(MainScreen.ROUTE_NAME);
              });
            }
            if (blocService is Failed) {
              print('======Failed======');
              PopDialog.showDownloadFailed(context);
            }
            return Container();
          },
          child: Container(),
        )
      ],
      child: Column(
        children: <Widget>[
          CircularProgressIndicator(),
          Text('Loading data...'),
        ],
      ),
    );
  }
}
