import 'package:attendance_application/src/models/employee_model.dart';

class PendingAttendanceModel {
  String date;
  String hour;
  String employeeId;
  String status;
  Employee employee;
  PersonalInfo personalInfo;

  PendingAttendanceModel({
    this.date,
    this.hour,
    this.employeeId,
    this.status,
    this.employee,
    this.personalInfo});

  PendingAttendanceModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    hour = json['hour'];
    employeeId = json['employeeId'];
    status = json['status'];
    employee = json['employee'];
    personalInfo = json['personalInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['hour'] = this.hour;
    data['employeeId'] = this.employeeId;
    data['status'] = this.status;
    data['employee'] = this.employee;
    data['personalInfo'] = this.personalInfo;
    return data;
  }
}
