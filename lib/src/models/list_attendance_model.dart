import 'package:attendance_application/src/models/employee_model.dart';

class ListAttendanceModel {
  String date;
  String hourEntry;
  String hourOut;
  String location;
  Employee employee;
  PersonalInfo personalInfo;

  ListAttendanceModel(
      {this.date,
        this.hourEntry,
        this.hourOut,
        this.location,
        this.employee,
        this.personalInfo});

  ListAttendanceModel.fromJson(Map<String, dynamic> json) {
    date = json['tanggal'];
    hourEntry = json['jamMasuk'];
    hourOut = json['jamKeluar'];
    location = json['location'];
    employee = json['employee'];
    personalInfo = json['personalInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tanggal'] = this.date;
    data['jamMasuk'] = this.hourEntry;
    data['jamKeluar'] = this.hourOut;
    data['location'] = this.location;
    data['employeeId'] = this.employee;
    data['personalInfo'] = this.personalInfo;
    return data;
  }
}