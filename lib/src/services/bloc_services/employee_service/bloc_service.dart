import 'package:attendance_application/src/models/attendance_model.dart';
import 'package:attendance_application/src/models/employee_model.dart';
import 'package:attendance_application/src/services/db_service/db_service.dart';
import 'package:attendance_application/src/utils/app_data.dart';
import 'package:attendance_application/src/utils/storage_io.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class EmployeeService {
  String url = API_URL;

  Response response;
  Dio dio = Dio();

  //dump employee data
  setEmployeeData() async {
    var token = await StorageIO().readStorage('token');
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.get(url + '/employee');

      await response.data.map((data) async {
        var setDataBase = await DbService().addEmployeeData(EmployeeModel(
          employee: Employee.fromJson(data),
          personalInfo: PersonalInfo.fromJson(data['personalInfo']),
          address: Address.fromJson(data['personalInfo']['address']),
          contactInfo: ContactInfo.fromJson(data['contactInfo']),
          workInfo: WorkInfo.fromJson(data['workInfo']),
        ));
        return setDataBase;
      }).toList();

      await DbService().addHistory(
          {
            "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
            "hour": DateFormat('HH:mm:ss').format(DateTime.now()),
            "status": "Pengunduhan semua data",
          }
      );

      return 'success';
    } catch (err) {
      throw Error();
    }
  }

  getListEmployeeProfile() async {
    var token = await StorageIO().readStorage('token');
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.get(url + '/employee');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw new Error();
      }
    } catch (err) {
      throw new Error();
    }
  }

  //check local db of list employee
  checkingDatabase() async {
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

  //submit attendance
  submitAttendance(employeeId, location, status) async {
    var token = await StorageIO().readStorage('token');
    var setLocation;
    try {
      setLocation = await DbService().getLocation();
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.post(url + '/absensiSubmit',
          data: [{
            "tanggal": DateFormat("yyyy-MM-dd").format(DateTime.now()),
            "jam": DateFormat("HH:mm:ss").format(DateTime.now()),
            "location": setLocation[0]['address'],
            "employeeId": employeeId
          }]
      );

      if (response.statusCode == 200) {
        return 'submitted';
      } else {
        throw new Error();
      }
    } catch (err) {
      print('===submit offline===');
      var result = await DbService().submitAttendanceLocal(AttendanceModel(
        employeeId: employeeId,
        location: setLocation[0]['address'],
        tanggal: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        jam: DateFormat('HH:mm:ss').format(DateTime.now()),
      ), status);
      print(result);
      return 'toLocal';
    }
  }

  submitCardAttendance(listEmployee, status) async {
    var token = await StorageIO().readStorage('token');
    try {
      print(listEmployee);
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.post(url + '/absensiSubmit', data: listEmployee);

      print('===submit card online===');
      if (response.statusCode == 200) {
        return 'submitted';
      } else {
        throw new Error();
      }
    } catch (err) {
      print('===submit card offline===');
      listEmployee.map((data) async {
        print(data['tanggal']);
        await DbService().submitAttendanceLocal(AttendanceModel(
          employeeId: data['employeeId'],
          tanggal: data['tanggal'],
          jam: data['jam'],
          location: data['location'],
        ), 'IN');
      }).toList();

      return 'toLocal';
    }
  }

  //scan attendance by qr code
  qrAttendance(scanner, cardId) async {
    var token = await StorageIO().readStorage('token');
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.get(url + '/scan/$scanner?id=$cardId');

      EmployeeModel employeeData = EmployeeModel(
          employee: Employee.fromJson(response.data),
          personalInfo: PersonalInfo.fromJson(response.data['personalInfo']),
          address: Address.fromJson(response.data['personalInfo']['address']),
          contactInfo: ContactInfo.fromJson(response.data['contactInfo']),
          workInfo: WorkInfo.fromJson(response.data['workInfo'])
      );

      Response date = await dio.get(
          url + '/listAbsensi?' + 'id=${employeeData.employee.id}&&tanggal=${DateFormat("yyyy-MM-dd").format(DateTime.now())}'
      );

      print('====scan qrcode online====');
      if (date.data == null) {
        return {"employee": employeeData, "status": "IN"};
      } else if (date.data['jamMasuk'] != null && date.data['jamKeluar'] != null) {
        return {"employee": employeeData, "status": null};
      } else if (date.data['jamMasuk'] != null && date.data['jamKeluar'] == null) {
        return {"employee": employeeData, "status": "OUT"};
      }

    } catch (err) {
      print('====scan qrcode offline====');
      var profile = await DbService().getEmployeeByCardId(cardId);
      var status = await DbService().checkAttendanceStatus(AttendanceModel(
        employeeId: profile.employee.id,
        tanggal: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      ));

      if (status.isEmpty) {
        return {'employee': profile, 'status': 'IN'};
      } else if (status.length == 2) {
        return {'employee': profile, 'status': null};
      } else {
        return {'employee': profile, 'status': 'OUT'};
      }
    }
  }

  //scan attendance by card id
  cardAttendance(scanner, cardId) async {
    var token = await StorageIO().readStorage('token');
    var setLocation = await DbService().getLocation();
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.get(url + '/scan' + '/$scanner?id=$cardId');

      EmployeeModel employeeData = EmployeeModel(
          employee: Employee.fromJson(response.data),
          personalInfo: PersonalInfo.fromJson(response.data['personalInfo']),
          address: Address.fromJson(response.data['personalInfo']['address']),
          contactInfo: ContactInfo.fromJson(response.data['contactInfo']),
          workInfo: WorkInfo.fromJson(response.data['workInfo'])
      );

      Response date = await dio.get(
          url + '/listAbsensi?id=${employeeData.employee.id}&&tanggal=${DateFormat("yyyy-MM-dd").format(DateTime.now())}');

      print('===scan online===');
      if (date.data == null) {
        return {"employee": employeeData, "status": 'IN', 'location': setLocation[0]['address']};
      } else if (date.data['jamMasuk'] != null && date.data['jamKeluar'] != null) {
        return {"employee": employeeData, "status": null, 'location': setLocation[0]['address']};
      } else if (date.data['jamMasuk'] != null && date.data['jamKeluar'] == null) {
        return {"employee": employeeData, "status": 'OUT', 'location': setLocation[0]['address']};
      }

    } catch (err) {
      print('====scan card offline====');
      var profile = await DbService().getEmployeeByCardId(cardId);
      var status = await DbService().checkAttendanceStatus(AttendanceModel(
        employeeId: profile.employee.id,
        tanggal: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      ));

      if (status.isEmpty) {
        return {'employee': profile, 'status': 'IN', 'location': setLocation[0]['address']};
      } else if (status.length == 2) {
        return {'employee': profile, 'status': null, 'location': setLocation[0]['address']};
      } else {
        return {'employee': profile, 'status': 'OUT', 'location': setLocation[0]['address']};
      }
    }
  }

  //get list all attendance from db (online)
  getListAttendance(date) async {
    var token = await StorageIO().readStorage('token');
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';

      if (date == null) {
        response = await dio.get(url + '/listAbsensi');
      } else {
        response = await dio.get(url + '/listAbsensi?tanggal=$date');
      }

      if (response.data.isNotEmpty) {
        return response.data;
      } else {
        return null;
      }
    } catch (err) {
      print(err);
      throw new Error();
    }
  }

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

  checkUpdate() async {
    var token = await StorageIO().readStorage('token');
    try{
      var historyVer = await DbService().checkLatestHistory();
      print(historyVer);

      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.get(url + '/employee?date=${historyVer[0]['date']}&hour=${historyVer[0]['hour']}');

      if (response.data.isNotEmpty) {
        return {'status': 'Pembaruan tersedia', 'update': true};
      } else {
        return {'status': 'Tidak ada pembaruan', 'update': false};
      }
    } catch (err) {
      throw new Error();
    }
  }

  updateEmployeeData() async {
    var token = await StorageIO().readStorage('token');
    try{
      var historyVer = await DbService().checkLatestHistory();

      dio.options.headers['Authorization'] = 'Bearer $token';
      response = await dio.get(url + '/employee?date=${historyVer[0]['date']}&hour=${historyVer[0]['hour']}');

      if (response.statusCode == 200) {

        response.data.map((listData) async {

            if (listData['status'] == 'Post') {

              await DbService().addEmployeeData(EmployeeModel(
                employee: Employee.fromJson(listData['employee']),
                personalInfo: PersonalInfo.fromJson(listData['employee']['personalInfo']),
                address: Address.fromJson(listData['employee']['personalInfo']['address']),
                contactInfo: ContactInfo.fromJson(listData['employee']['contactInfo']),
                workInfo: WorkInfo.fromJson(listData['employee']['workInfo']),
              ));

              await DbService().addHistory({
                    "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    "hour": DateFormat('HH:mm:ss').format(DateTime.now()),
                    "status": 'Penambahan data karyawan baru',
              });

            } else if (listData['status'] == 'Update') {

              await DbService().updateEmployeeData(EmployeeModel(
                employee: Employee.fromJson(listData['employee']),
                personalInfo: PersonalInfo.fromJson(listData['employee']['personalInfo']),
                address: Address.fromJson(listData['employee']['personalInfo']['address']),
                contactInfo: ContactInfo.fromJson(listData['employee']['contactInfo']),
                workInfo: WorkInfo.fromJson(listData['employee']['workInfo']),
              ));

              await DbService().addHistory({
                    "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    "hour": DateFormat('HH:mm:ss').format(DateTime.now()),
                    "status": 'Pembaruan data karyawan',
              });

            }
        }).toList();

        return 'success';

      } else {
        throw new Error();
      }
    } catch (err) {
      throw new Error();
    }
  }

  setLocation() async {
    try {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      List<Placemark> setLocation = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude)
        .catchError((onError) {
          throw Error();
      });
      Placemark location = setLocation[0];
      String newLocation = '${location.thoroughfare} ${location.subThoroughfare}, '
          '${location.subLocality}, '
          '${location.locality}, '
          '${location.subAdministrativeArea}, '
          '${location.administrativeArea}';

      await DbService().setLocation(newLocation);
      print(newLocation);

      return 'success';
    } catch (err) {
      throw Error();
    }
  }

  getLocation() async {
    try {
      var address = await DbService().getLocation();
      print(address);
      if (address.isEmpty) {
        throw Error();
      } else {
        return address;
      }
    } catch (err) {
      throw Error();
    }
  }
}
