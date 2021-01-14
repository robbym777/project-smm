import 'package:attendance_application/src/screens/home_screen.dart';
import 'package:attendance_application/src/screens/loading_screen.dart';
import 'package:attendance_application/src/screens/main_screen.dart';
import 'package:attendance_application/src/services/bloc_services/authentication/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/authentication/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/authentication/bloc_state.dart';

import 'package:attendance_application/src/utils/pop_dialog.dart';
import 'package:attendance_application/src/services/google_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class GoogleAuthButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<AuthBlocService>(context),
      listener: (context, serviceBloc) async {
        if (serviceBloc is Success) {
          print('=====Success=====');
          Navigator.of(context).pushNamedAndRemoveUntil(
              LoadingScreen.ROUTE_NAME,
              ModalRoute.withName(LoadingScreen.ROUTE_NAME)
          );
        }
        if (serviceBloc is Invalid) {
          print('=====Invalid=====');
          Navigator.of(context).pop();
          PopDialog.showLoginFailed(context);
          GoogleAuth().signOutGoogle();
        }
        if (serviceBloc is Failed) {
          print('=====Failed=====');
          Navigator.of(context).pop();
          PopDialog.showNoInternetConnection(context);
          GoogleAuth().signOutGoogle();
        }
        if(serviceBloc is Waiting) {
          Navigator.of(context).pop();
        }
      },
      child: OutlineButton(
        onPressed: () {
          PopDialog.showLoadingDialog(context);
          context.bloc<AuthBlocService>().add(Authentication());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/img/icons/google_logo.png', height: 25),
            SizedBox(width: 10),
            Text('Masuk dengan akun google', style: TextStyle(fontSize: 16))
          ],),
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
        padding: EdgeInsets.all(10),
        highlightElevation: 10,
        textColor: Colors.grey,
      ),
    );
  }
}
