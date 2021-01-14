import 'package:attendance_application/src/models/attendance_model.dart';
import 'package:attendance_application/src/models/employee_model.dart';
import 'package:attendance_application/src/services/db_service/db_service.dart';
import 'package:attendance_application/src/utils/app_data.dart';
import 'package:attendance_application/src/utils/storage_io.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class SubmitPendingService {
  String url = API_URL;

  Response response;
  Dio dio = Dio();

  submitAllPendingAttendance() async {
    var token = await StorageIO().readStorage('token');
    try {
      var listAttendance = await DbService().getAttendance();

      print(listAttendance);
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.post(url + '/absensiSubmit', data: listAttendance);

      print(response.statusCode);
      if (response.statusCode != 200) {
        throw new Error();
      } else {
        await DbService().deleteAttendance();
        return 'success';
      }
    } catch (err) {
      throw new Error();
    }
  }

}
