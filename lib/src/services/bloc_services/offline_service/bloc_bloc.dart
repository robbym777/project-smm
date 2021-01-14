import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_state.dart';
import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_service.dart';
import 'package:bloc/bloc.dart';

class OfflineBlocService extends Bloc<BlocEvent, BlocState>{
  final offlineService = OfflineService();

  @override
  BlocState get initialState => Waiting();

  @override
  Stream<BlocState>mapEventToState(BlocEvent event) async* {
    if(event is CheckingLocalDatabase){
      yield Loading();
      try{
        final result = await offlineService.checkingLocalDatabase();
        yield NoData(data: result);
      } catch(e){
        yield DataAlready(data: e);
      }
    }

    if(event is PendingAttendance){
      try{
        final result = await offlineService.getAttendanceList();
        yield ListPendingAttendance(data: result);
      } catch(e){
        print(e);
        yield ListPendingIsNull(data: e);
      }
    }

    if(event is PendingAttendanceByDate){
      try{
        final result = await offlineService.getAttendanceListByDate(event.date);
        yield ListPendingAttendance(data: result);
      } catch(e){
        print(e);
        yield ListPendingIsNull(data: e);
      }
    }

    if(event is GetLocalHistory) {
      try {
        final result = await offlineService.getLocalHistory();
        yield ListLocalHistory(data: result);
      } catch (err) {
        yield LocalHistoryEmpty(data: err);
      }
    }
  }
}