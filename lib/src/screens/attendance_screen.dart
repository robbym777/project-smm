import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_state.dart';
import 'package:attendance_application/src/utils/pop_dialog.dart';
import 'package:attendance_application/src/widget/scanner_widget/card_scanner.dart';
import 'package:attendance_application/src/widget/scanner_widget/scan_result.dart';
import 'package:attendance_application/src/widget/scanner_widget/qr_scanner_button.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:audioplayers/audio_cache.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
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
    context.bloc<EmployeeBlocService>().add(GetLocation());
    return BlocListener(
      bloc: BlocProvider.of<EmployeeBlocService>(context),
      listener: (context, blocService) async {
        if (blocService is ScanSuccess) {
          Navigator.of(context).pop();

          PopDialog.showBottomDialog(context, ScanResult());
          _audioCache.play('beep_short.mp3');
        }
        if (blocService is ScanFailed) {
          Navigator.of(context).pop();

          PopDialog.showEmployeeNotFound(context);
        }
        if (blocService is SubmitSuccess) {
          Navigator.of(context).pop();

          Fluttertoast.showToast(
              msg: 'Absensi berhasil ',
              backgroundColor: Colors.black38,
              gravity: ToastGravity.CENTER
          );
        }
        if (blocService is SubmitToLocal) {
          Navigator.of(context).pop();

          Fluttertoast.showToast(
              msg: 'Anda tidak terhubung ke server, untuk sementara data masuk ke local db ',
              backgroundColor: Colors.black38,
              gravity: ToastGravity.CENTER
          );
        }

        if (blocService is SuccessLocation) {
          print('success');
          context.bloc<EmployeeBlocService>().add(SetLocation());
        }
        if (blocService is FailedLocation) {
          print('failed');
          context.bloc<EmployeeBlocService>().add(SetLocation());
        }

        if (blocService is LocationApplied) {
          Fluttertoast.showToast(
              msg: 'Lokasi diterapkan ',
              backgroundColor: Colors.black38,
              gravity: ToastGravity.BOTTOM
          );
        }
        if (blocService is FailedSetLocation) {
          Fluttertoast.showToast(
              msg: 'Lokasi diterapkan ',
              backgroundColor: Colors.black38,
              gravity: ToastGravity.BOTTOM
          );
        }
      },
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: QrScannerButton(),
            ),
            Divider(thickness: 2),
            Expanded(
                flex: 10,
                child: CardScanner()
            )
          ],
        ),
      ),
    );
  }
}
