import 'package:attendance_application/src/services/db_service/db_service.dart';
import 'package:attendance_application/src/utils/app_data.dart';

class OfflineService {
  String url = API_URL;

  checkingLocalDatabase() async {
    try {
      List<Map<String, dynamic>> checkResult = await DbService().getAllEmployeeData();
      if (checkResult.isEmpty) {
        return checkResult;
      } else {
        throw Error();
      }
    } catch (err) {
      throw Error();
    }
  }

  getAttendanceList() async {
    try {
      List<Map<String, dynamic>> result = await DbService().getAllAttendance();
      if (result.isNotEmpty) {
        return result;
      } else {
        throw new Error();
      }
    } catch (err) {
      throw Error();
    }
  }

  getAttendanceListByDate(date) async {
    try {
      List<Map<String, dynamic>> result = await DbService().getAttendanceByDate(date);
      if (result.isNotEmpty) {
        return result;
      } else {
        throw new Error();
      }
    } catch (err) {
      throw Error();
    }
  }

  getLocalHistory() async {
    try {
      List<Map<String, dynamic>> result = await DbService().getAllHistory();

      if (result.isNotEmpty) {
        return result;
      } else {
        throw new Error();
      }
    } catch (err) {
      throw Error();
    }
  }
}