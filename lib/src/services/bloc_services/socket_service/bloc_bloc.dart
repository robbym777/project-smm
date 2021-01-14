import 'package:attendance_application/src/services/bloc_services/socket_service/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/socket_service/bloc_service.dart';
import 'package:attendance_application/src/services/bloc_services/socket_service/bloc_state.dart';
import 'package:bloc/bloc.dart';

class SocketBlocService extends Bloc<BlocEvent, BlocState>{
  SocketBlocService() {
    checkConnection(String connection) {
      this.add(CheckConnection(status: connection));
    }

    SocketService(checkConnection)..checkConnection();
  }

  @override
  BlocState get initialState => Waiting();

  @override
  Stream<BlocState>mapEventToState(BlocEvent event) async* {
    if(event is CheckConnection){
      yield Loading();
      try{
        print('========Status========');
        print(event.status);
        switch(event.status) {
          case 'connect' :
            yield Connected(status: 'connected');
            break;
          case 'reconnect' :
          case 'reconnecting' :
          case 'reconnect_attempt' :
            yield Reconnecting(status: 'reconnecting');
            break;
          case 'disconnect' :
          case 'connect_error' :
          case 'connect_timeout' :
          case 'reconnect_error' :
            yield Disconnected(status: 'disconnected');
        }
      }catch(e){
        print(e);
      }
    }
  }
}