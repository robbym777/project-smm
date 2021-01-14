import 'package:attendance_application/src/models/employee_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BlocState{}

class Waiting extends BlocState{}

class Loading extends BlocState{}

//Process
class Success extends BlocState{
  final data;
  Success({this.data});
}
class Failed extends BlocState{
  final data;
  Failed({this.data});
}

class SubmitPendingSuccess extends BlocState{
  final data;
  SubmitPendingSuccess({this.data});
}
class SubmitPendingFailed extends BlocState{
  final data;
  SubmitPendingFailed({this.data});
}