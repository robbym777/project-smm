abstract class BlocEvent {}

class CheckingLocalDatabase extends BlocEvent {}

class PendingAttendance extends BlocEvent {}

class PendingAttendanceByDate extends BlocEvent {
  final date;

  PendingAttendanceByDate({this.date});
}

class ListLocalEmployee extends BlocEvent {}

class GetLocalHistory extends BlocEvent{}