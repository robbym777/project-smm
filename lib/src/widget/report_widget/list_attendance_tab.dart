import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_event.dart';
import 'package:attendance_application/src/widget/report_widget/custom_filter_tab.dart';
import 'package:attendance_application/src/widget/report_widget/display_all_attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ListAttendanceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CustomFilterTab(
              getAll: () {
                context.bloc<EmployeeBlocService>().add(ListAttendance());
              },
              pickDate: (val) {
                context.bloc<EmployeeBlocService>().add(ListAttendance(date:DateFormat('yyyy-MM-dd').format(val)));
              },
            ),
          ),
        ),
        SizedBox(height: 5),
        Expanded(
          flex: 16,
          child: DisplayListAttendance()
        ),
      ],
    );
  }
}
