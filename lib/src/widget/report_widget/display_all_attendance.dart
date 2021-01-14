import 'package:attendance_application/src/models/employee_model.dart';
import 'package:attendance_application/src/models/list_attendance_model.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_state.dart';
import 'package:attendance_application/src/utils/app_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class DisplayListAttendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.bloc<EmployeeBlocService>().add(ListAttendance());
    return BlocBuilder(
      bloc: BlocProvider.of<EmployeeBlocService>(context),
      builder: (context, blocService) {
        if (blocService is GetListSuccess) {
          return RefreshIndicator(
            onRefresh: () {
              context.bloc<EmployeeBlocService>().add(ListAttendance());
            },
            color: Colors.blue,
            child: Container(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: blocService.data.map<Widget>((data) {

                  ListAttendanceModel listData = ListAttendanceModel(
                    date: data['tanggal'],
                    hourEntry: data['jamMasuk'],
                    hourOut: data['jamKeluar'],
                    employee: Employee.fromJson(data['employee']),
                    personalInfo: PersonalInfo.fromJson(data['employee']['personalInfo']),
                  );

                  return Card(
                    elevation: 5,
                    child: ListTile(
                      onTap: () {},
//                      dense: true,
//                      contentPadding: EdgeInsets.all(5),
                      isThreeLine: true,
                      leading: CircleAvatar(
                        maxRadius: 25,
                        backgroundImage: NetworkImage(listData.personalInfo.photo),
                      ),
                      title: Text(listData.personalInfo.name),
                      subtitle: Text('Tanggal : ' + listData.date),
                      trailing: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: hourEntryColor, width: 2)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('IN'),
                                    Text(listData.hourEntry == null ? '-' : listData.hourEntry),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: hourOutColor, width: 2)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('OUT'),
                                    Text(listData.hourOut == null ? '-' : listData.hourOut),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        }
        if (blocService is ListIsNull) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(child: Icon(LineIcons.calendar_times_o, size: 50)),
                Center(child: Text('Tidak ada data absensi'))
              ],
            ),
          );
        }
        if (blocService is NoConnection) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(child: Icon(Icons.signal_wifi_off, size: 50)),
                Center(child: Text('Tadak ada koneksi'))
              ],
            ),
          );
        }
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor
              ))),
              Center(child: Text('Loading data...'))
            ],
          ),
        );
      },
    );
  }
}
