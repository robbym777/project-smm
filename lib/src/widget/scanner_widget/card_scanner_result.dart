import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_state.dart';
import 'package:attendance_application/src/utils/pop_dialog.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

class CardScannerResult extends StatefulWidget {
  @override
  _CardScannerResultState createState() => _CardScannerResultState();
}

class _CardScannerResultState extends State<CardScannerResult> {
  List<dynamic> cardScan = [];
  List<dynamic> attendance = [];
  AudioCache _audioCache;

  @override
  void initState() {
    _audioCache = AudioCache(
        prefix: 'audio/',
        fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<EmployeeBlocService>(context),
      listener: (context, blocService) {
        if (blocService is CardScanSuccess) {
          var check = cardScan.indexWhere((check) => check['data']['personalInfo']['name'] == blocService.data.personalInfo.name);
          if (check == -1) {
            setState(() {
              cardScan.add({"data": blocService.data.toJson(), "status": blocService.status});
              attendance.add({
                    'tanggal' : DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    'jam' : DateFormat('HH:mm:ss').format(DateTime.now()),
                    'location' : blocService.location,
                    'employeeId': blocService.data.employee.id
                  });
            });
            _audioCache.play('beep_short.mp3');
          } else {
            _audioCache.play('beep_warn.mp3');
            Fluttertoast.showToast(
                msg: 'Card ID sudah di scan ',
                backgroundColor: Colors.black38,
                gravity: ToastGravity.CENTER
            );
          }
        }
        if (blocService is CardScanFailed) {
          Fluttertoast.showToast(
              msg: 'Ada kesalahan ',
              backgroundColor: Colors.black38,
              gravity: ToastGravity.CENTER
          );
        }

        if (blocService is SubmitSuccess) {
          setState(() {
            cardScan.clear();
            attendance.clear();
          });
        }
        if (blocService is SubmitToLocal) {
          setState(() {
            cardScan.clear();
            attendance.clear();
          });
        }
        return Container();
      },
      child: Scaffold(
        body: Container(
          child: cardScan.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 100),
                  CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 70,
                      child: Image.asset('assets/img/background/uhf_icon.png')
                  )
                ],
              )
            : ListView(
                padding: EdgeInsets.all(5),
                children: cardScan.isEmpty
                    ? <Widget>[]
                    : cardScan.map<Widget>((data) {
                        return Card(
                          color: data['status'] == null
                            ? Colors.grey
                            : data['status'] == 'IN'
                              ? Colors.green
                              : Colors.red,
                          child: ListTile(
                            leading: CircleAvatar(
                              maxRadius: 25,
                              backgroundImage: data['data']['personalInfo']['photo'] == null
                                  ? AssetImage('assets/img/icons/icon-profile.png')
                                  : NetworkImage(data['data']['personalInfo']['photo']),
                            ),
                            title: Text(data['data']['personalInfo']['name']),
                            subtitle: Text('CARD ID : ' + data['data']['workInfo']['nfcId'],
                                style: TextStyle(fontFamily: 'Arial')
                            ),
                            trailing: Text(data['status'] == null? '' : data['status']),
                            isThreeLine: true,
                            dense: true,
                          ),
                        );
                      }).toList(),
              ),
        ),
        floatingActionButton: cardScan.isEmpty
            ? Container()
            : FloatingActionButton.extended(
                onPressed: () {
//                  print(attendance);
                  PopDialog.showProcessDialog(context);

                  context.bloc<EmployeeBlocService>().add(SubmitCardAttendance(listEmployee: attendance));
                },
                icon: Icon(LineIcons.check_circle_o),
                label: Text('Submit'),
              ),
      ),
    );
  }
}
