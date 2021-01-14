import 'package:attendance_application/src/models/employee_model.dart';

abstract class BlocState{}

class Waiting extends BlocState{}

class Loading extends BlocState{}

class Success extends BlocState{
  final data;
  Success({this.data});
}

class Invalid extends BlocState{
  final data;
  Invalid({this.data});
}

class Failed extends BlocState{
  final data;
  Failed({this.data});
}

class Authenticated extends BlocState{
  final EmployeeModel data;

  Authenticated({this.data});
}

class NoAuthentication extends BlocState{
  final data;

  NoAuthentication({this.data});
}