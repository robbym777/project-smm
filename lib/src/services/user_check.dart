import 'package:attendance_application/src/screens/loading_screen.dart';
import 'package:attendance_application/src/services/bloc_services/authentication/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/authentication/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/authentication/bloc_state.dart';

import 'package:attendance_application/src/services/checking_data.dart';
import 'package:attendance_application/src/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCheck extends StatelessWidget {
  static const ROUTE_NAME = '/user_check';

  @override
  Widget build(BuildContext context) {
    context.bloc<AuthBlocService>().add(CheckAuthentication());
    return BlocListener(
      bloc: BlocProvider.of<AuthBlocService>(context),
      listener: (context, checkService) {
        if (checkService is NoAuthentication) {
          print('====== Not Authenticated =====');
          Navigator.of(context).pushReplacementNamed(LoginScreen.ROUTE_NAME);
        }
        if (checkService is Authenticated) {
          print('====== Authenticated =====');
          Navigator.of(context).pushReplacementNamed(LoadingScreen.ROUTE_NAME);
        }
      },
      child: CheckingData(),
    );
  }
}
