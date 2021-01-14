abstract class BlocState{}

class Waiting extends BlocState{}

class Loading extends BlocState{}

class NoData extends BlocState{
  final data;
  NoData({this.data});
}
class DataAlready extends BlocState{
  final data;
  DataAlready({this.data});
}

class ListPendingAttendance extends BlocState{
  final data;

  ListPendingAttendance({this.data});
}
class ListPendingIsNull extends BlocState{
  final data;

  ListPendingIsNull({this.data});
}

class ListLocalHistory extends BlocState{
  final data;

  ListLocalHistory({this.data});
}

class LocalHistoryEmpty extends BlocState{
  final data;

  LocalHistoryEmpty({this.data});
}