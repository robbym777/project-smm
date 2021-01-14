import 'package:attendance_application/src/services/bloc_services/submit_pending/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/submit_pending/bloc_service.dart';
import 'package:attendance_application/src/services/bloc_services/submit_pending/bloc_state.dart';
import 'package:bloc/bloc.dart';

class SubmitPendingBloc extends Bloc<BlocEvent, BlocState>{
  final submitPendingService = SubmitPendingService();

  @override
  BlocState get initialState => Waiting();

  @override
  Stream<BlocState>mapEventToState(BlocEvent event) async* {

    if(event is SubmitPendingAttendance) {
      try{
        final result = await submitPendingService.submitAllPendingAttendance();
        yield SubmitPendingSuccess(data: result);
      }catch(e){
        print(e);
        yield SubmitPendingFailed(data: e);
      }
    }
  }
}