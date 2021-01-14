import 'package:attendance_application/src/utils/app_data.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:dio/dio.dart';

class SocketService {
  String url = API_URL;
  IO.Socket socket;
  SocketIO socketIO;
  Function callback;

  SocketService(this.callback);
  //CheckingLocalData
  checkConnection() async {
    try {
      String result;
      socketIO = SocketIOManager().createSocketIO(
          url,
          '/',
          socketStatusCallback: callback
      );
      socketIO.destroy();
      socketIO.init();
      socketIO.connect();
    } catch (err) {
      print(err);
      throw Error();
    }
  }
}
