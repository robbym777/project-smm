abstract class BlocEvent {}

//Set Employee Profile
class SetEmployeeProfile extends BlocEvent {}

//CheckingDatabase
class CheckingDatabase extends BlocEvent {}

//Get list Employee from Database(online)
class GetListEmployee extends  BlocEvent {}

//Submit Attendance
class SubmitAttendance extends BlocEvent {
  final employeeId;
  final location;
  final status;

  SubmitAttendance({this.employeeId, this.location, this.status});
}

class SubmitCardAttendance extends BlocEvent {
  final listEmployee;
  final status;

  SubmitCardAttendance({this.listEmployee, this.status});
}

//QR Attendance
class EmployeeQRAttendance extends BlocEvent {
  final scanner;
  final id;

  EmployeeQRAttendance({this.scanner, this.id});
}

//Card Attendance
class EmployeeCardAttendance extends BlocEvent {
  final scanner;
  final id;

  EmployeeCardAttendance({this.scanner, this.id});
}

//List Attendance
class ListAttendance extends BlocEvent {
  final date;
  ListAttendance({this.date});
}

//Submit All Pending Attendance
class SubmitPendingAttendance extends BlocEvent {}

//Update Employee Data
class CheckUpdateEmployee extends BlocEvent {}

class UpdateEmployee extends BlocEvent {}

class SetLocation extends BlocEvent {}

class GetLocation extends BlocEvent{}