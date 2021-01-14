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

class ListEmployeeSuccess extends BlocState{
  final data;
  ListEmployeeSuccess({this.data});
}

class ListEmployeeFailed extends BlocState{
  final data;
  ListEmployeeFailed({this.data});
}

//Scan Attendance State
class ScanSuccess extends BlocState{
  final EmployeeModel data;
  final status;
  ScanSuccess({this.data, this.status});
}
class ScanFailed extends BlocState{
  final data;
  ScanFailed({this.data});
}

class CardScanSuccess extends BlocState{
  final data;
  final status;
  final location;

  CardScanSuccess({this.data, this.status, this.location});
}
class CardScanFailed extends BlocState{
  final data;
  CardScanFailed({this.data});
}

//Submit Attendance State
class SubmitSuccess extends BlocState{
  final data;
  SubmitSuccess({this.data});
}
class SubmitToLocal extends BlocState{
  final data;
  SubmitToLocal({this.data});
}
class SubmitFailed extends BlocState{
  final data;
  SubmitFailed({this.data});
}

//List Attendance State
class GetListSuccess extends BlocState{
  final data;
  GetListSuccess({this.data});
}
class ListIsNull extends BlocState{
  final data;
  ListIsNull({this.data});
}

class SubmitPendingSuccess extends BlocState{
  final data;
  SubmitPendingSuccess({this.data});
}
class SubmitPendingFailed extends BlocState{
  final data;
  SubmitPendingFailed({this.data});
}

//Update Employee Data
class UpdateMessage extends BlocState{
  final status;
  final isUpdate;

  UpdateMessage({this.status, this.isUpdate});
}

//Error State
class NoConnection extends BlocState{
  final data;
  NoConnection({this.data});
}

class UpdateSuccess extends BlocState{
  final message;

  UpdateSuccess({this.message});
}
class UpdateFailed extends BlocState{
  final message;

  UpdateFailed({this.message});
}

class LocationApplied extends BlocState{
  final data;

  LocationApplied({this.data});
}

class FailedSetLocation extends BlocState{
  final data;

  FailedSetLocation({this.data});
}

class SuccessLocation extends BlocState{
  final data;

  SuccessLocation({this.data});
}

class FailedLocation extends BlocState {
  final data;

  FailedLocation({this.data});
}