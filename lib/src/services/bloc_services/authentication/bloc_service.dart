import 'dart:convert';

import 'package:attendance_application/src/models/employee_model.dart';
import 'package:attendance_application/src/models/google_model.dart';
import 'package:attendance_application/src/services/db_service/db_service.dart';
import 'package:attendance_application/src/services/google_auth.dart';
import 'package:attendance_application/src/utils/app_data.dart';
import 'package:attendance_application/src/utils/storage_io.dart';
import 'package:dio/dio.dart';

class AuthService {
  String url = API_URL;
  Response response;
  Dio dio = Dio();

  //Authentication with Google Account
  authentication() async {
    try {
      GoogleData staff;
      await GoogleAuth().signInWithGoogle().then((val) {
        staff = GoogleData(
            uid         : val.uid,
            displayName : val.displayName,
            email       : val.email,
            phoneNo     : val.phoneNumber,
            photoUrl    : val.photoUrl
        );
      }).catchError((err) {
        throw (err);
      });

      response = await dio.post(url + '/auth?email=${staff.email}', data: {'img': staff.photoUrl});

      if (response.statusCode == 401 && response.data['message'] == 'Unauthorized') {
        print('test');
        return null;
      } else {
        var addProfile = await DbService().addStaffProfile(EmployeeModel(
            employee: Employee.fromJson(response.data['staffData']),
            personalInfo: PersonalInfo.fromJson(response.data['staffData']['personalInfo']),
            address: Address.fromJson(response.data['staffData']['personalInfo']['address']),
            contactInfo: ContactInfo.fromJson(response.data['staffData']['contactInfo']),
            workInfo: WorkInfo.fromJson(response.data['staffData']['workInfo'])
        ));
        await StorageIO().writeStorage('token', response.data['token']);
        return addProfile;
      }
    } catch (err) {
      throw (err);
    }
  }

  //Check Authentication
  checkAuthentication() async {
    try {
      final getData = await DbService().getStaffProfile();
      if (getData != null) {
        return getData;
      } else {
        throw Error();
      }
    } catch (err) {
      throw Error();
    }
  }
}
