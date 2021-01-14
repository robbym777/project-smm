import 'package:attendance_application/src/screens/list_employee_screen.dart';
import 'package:attendance_application/src/screens/loading_screen.dart';
import 'package:attendance_application/src/services/bloc_services/authentication/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/socket_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/submit_pending/bloc_bloc.dart';

import 'package:attendance_application/src/services/user_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/screens/login_screen.dart';
import 'src/screens/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBlocService(),
        ),
        BlocProvider(
          create: (context) => EmployeeBlocService(),
        ),
        BlocProvider(
          create: (context) => OfflineBlocService(),
        ),
        BlocProvider(
          create: (context) => SocketBlocService(),
        ),
        BlocProvider(
          create: (context) => SubmitPendingBloc(),
        ),
      ],
      child: MaterialApp(
          title: 'Sinarmas Mining',
          theme: ThemeData(
              primarySwatch: Colors.red,
              secondaryHeaderColor: Colors.white,
              accentColor: Colors.grey,
              canvasColor: Colors.white,
              fontFamily: 'Raleway',
              textTheme: TextTheme(
                  title: TextStyle(color: Colors.black)
              )
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: UserCheck.ROUTE_NAME,
          routes: {
            LoadingScreen.ROUTE_NAME: (_) => LoadingScreen(),
            UserCheck.ROUTE_NAME: (_) => UserCheck(),
            LoginScreen.ROUTE_NAME: (_) => LoginScreen(),
            MainScreen.ROUTE_NAME: (_) => MainScreen(),
            ListEmployeeScreen.ROUTE_NAME: (_) => ListEmployeeScreen(),
          },
        )
    );
  }
}
