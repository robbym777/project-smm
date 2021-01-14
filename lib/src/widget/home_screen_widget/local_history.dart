import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class LocalHistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.bloc<OfflineBlocService>().add(GetLocalHistory());
    return BlocBuilder(
      bloc: BlocProvider.of<OfflineBlocService>(context),
      builder: (context, blocService) {
        if (blocService is ListLocalHistory) {
          return Card(
            elevation: 10,
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        children: <Widget>[
                          Expanded(flex: 1,child: Icon(LineIcons.newspaper_o)),
                          Expanded(
                            flex: 6,
                            child: Text('Catatan pembaruan data local',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Theme.of(context).secondaryHeaderColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Expanded(flex: 1, child: Text('Tanggal', style: TextStyle(fontWeight: FontWeight.bold))),
                                  Expanded(flex: 1, child: Text('Catatan', style: TextStyle(fontWeight: FontWeight.bold))),
                                ],
                              )
                          ),
                          Expanded(
                            flex: 6,
                            child: ListView(
                              children: blocService.data.map<Widget>((data) {
                                return Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(flex: 1, child: Text(data['date'])),
                                        Expanded(flex: 1, child: Text(data['status'])),
                                      ],
                                    ),
                                    Divider(thickness: 1)
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        if (blocService is LocalHistoryEmpty) {
          return Container(
            child: Center(
              child: Text('No History'),
            ),
          );
        }
        return Container();
      },
    );
  }
}
