import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_event.dart';

import 'package:attendance_application/src/widget/loading_screen_widget/bottom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingScreen extends StatelessWidget {
  static const ROUTE_NAME = '/loading';

  @override
  Widget build(BuildContext context) {
    context.bloc<OfflineBlocService>().add(CheckingLocalDatabase());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Image.asset('assets/img/icons/sinarmas-mining-logo.png')
                ),
                BottomLoading(),
              ],
            ),
          ),
        ),
    );
  }
}
