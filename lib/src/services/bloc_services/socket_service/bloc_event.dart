abstract class BlocEvent{}

//GetLocalData
class CheckConnection extends BlocEvent{
  final status;
  CheckConnection({this.status});
}