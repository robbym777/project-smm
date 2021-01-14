import 'package:attendance_application/src/models/employee_model.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_state.dart';
import 'package:attendance_application/src/widget/scanner_widget/address_data.dart';
import 'package:attendance_application/src/widget/scanner_widget/attend_complete.dart';
import 'package:attendance_application/src/widget/scanner_widget/data_result.dart';
import 'package:attendance_application/src/widget/scanner_widget/submit_attend_in.dart';
import 'package:attendance_application/src/widget/scanner_widget/submit_attend_out.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ScanResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<EmployeeBlocService>(context),
      builder: (context, blocService) {
        if (blocService is ScanSuccess) {
          EmployeeModel employee = blocService.data;
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(flex: 1,
                              child: employee.personalInfo.photo == ''
                                      ? Image.asset('assets/img/icons/icon-profile.png')
                                      : CircleAvatar(backgroundImage : NetworkImage(employee.personalInfo.photo,), minRadius: 50)
                          ),
                          SizedBox(width: 10),
                          Expanded(flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(employee.personalInfo.name,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                  SizedBox(height: 10),
                                  Text('CARD ID'),
                                  Text(employee.workInfo.nfcId,
                                      style: TextStyle(fontFamily: 'Arial', fontWeight: FontWeight.bold, color: Colors.grey)
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Card(
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  DataResult(title: 'Jenis Kelamin', value: employee.personalInfo.gender),
                                  DataResult(title: 'Tempat Lahir', value: employee.personalInfo.birthPlace),
                                  DataResult(title: 'Tanggal Lahir', value: employee.personalInfo.birthDate),
                                  DataResult(title: 'Golongan Darah', value: employee.personalInfo.bloodType),
                                  AddressData(title: 'Alamat', addressData: employee.address,)
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  DataResult(title: 'Nomor Telepon', value: employee.contactInfo.phoneNumber),
                                  DataResult(title: 'Email', value: employee.contactInfo.email),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  DataResult(title: 'Departemen', value: employee.workInfo.dept),
                                  DataResult(title: 'Posisi', value: employee.workInfo.title),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: blocService.status == null
                        ? AttendComplete()
                        : blocService.status == 'IN'
                          ? SubmitAttendIn(employeeId: employee.employee.id)
                          : SubmitAttendOut(employeeId: employee.employee.id)
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SimpleDialog(
          children: <Widget>[
            Center(child: CircularProgressIndicator()),
            Center(child: Text('Processing...')),
          ],
        );
      },
    );
  }
}
