import 'package:attendance_application/src/widget/list_employee_widget/list_employee.dart';
import 'package:flutter/material.dart';

class ListEmployeeScreen extends StatelessWidget {
  static const ROUTE_NAME = 'listEmployee';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Karyawan'),
      ),
      body: ListEmployee(),
    );
  }
}
