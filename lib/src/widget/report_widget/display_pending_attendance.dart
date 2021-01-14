import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_state.dart';
import 'package:attendance_application/src/utils/app_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class DisplayPendingAttendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.bloc<OfflineBlocService>().add(PendingAttendance());
    return BlocBuilder(
      bloc: BlocProvider.of<OfflineBlocService>(context),
      builder: (context, blocService) {
        if (blocService is ListPendingAttendance) {
          return Container(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: blocService.data.map<Widget>((data) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    onTap: () {},
                    isThreeLine: true,
                    leading: CircleAvatar(
                      maxRadius: 25,
                      backgroundImage: AssetImage('assets/img/icons/icon-profile.png'),
                    ),
                    title: Text(data['name']),
                    subtitle: Text('Tanggal : ' + data['tanggal']),
                    trailing: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: data['status'] == 'IN' ? hourEntryColor : hourOutColor, width: 2)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(data['status']),
                                  Text(data['jam']),
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
          );
        }
        if (blocService is ListPendingIsNull) {
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor
            ))),
            Text('Loading data...')
          ],
        );
      },
    );
  }
}
