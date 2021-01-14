abstract class BlocState{}

class Waiting extends BlocState{}

class Loading extends BlocState{}

class Connected extends BlocState{
  final status;
  Connected({this.status});
}

class Reconnecting extends BlocState{
  final status;
  Reconnecting({this.status});
}


class Disconnected extends BlocState{
  final status;
  Disconnected({this.status});
}