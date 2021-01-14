import 'dart:async';

import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_event.dart';
import 'package:attendance_application/src/utils/pop_dialog.dart';
import 'package:latlong/latlong.dart';
import 'package:attendance_application/src/widget/scanner_widget/card_scanner_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wakelock/wakelock.dart';

class CardScanner extends StatefulWidget {
  @override
  _CardScannerState createState() => _CardScannerState();
}

class _CardScannerState extends State<CardScanner> {
  static const platform = const MethodChannel('info.mylabstudio.dev/smm');

  String _deviceInfo = '';
  List listCardId = [];

  @override
  void initState() {
    Wakelock.enable();
    _initDevice();
    super.initState();
  }

  Future _getIdCardInfo() async {
    String idCard;
    try {
      final String result = await platform.invokeMethod('scanIDCard');
      print('=============');
      print(result);
//      PopDialog.showLoadingDialog(context);
      BlocProvider.of<EmployeeBlocService>(context).add(EmployeeCardAttendance(scanner: 'nfc', id: result));
      idCard = result;
      setState(() {
        listCardId.add(idCard);
      });
    } on PlatformException catch (e) {
      idCard = "'${e.message}'.";
    } finally {
//      await _disposeDevice();
    }
  }

  Future _initDevice() async {
    String deviceInfo = '';
    try {
      final bool result = await platform.invokeMethod('initUhfReader');
      if (result) {
        deviceInfo = 'CARD scanner is ready';
      }
    } on PlatformException catch (e) {
      if (e.code == '001') {
        deviceInfo = 'CARD scanner is ready';
      } else {
        deviceInfo = e.message;
      }
    }
    setState(() {
      _deviceInfo = deviceInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();
    return Column(
      children: <Widget>[
//        RaisedButton(
//          onPressed: () async {
//            Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//            List<Placemark> location = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
//            print(location[0].toJson());
//            BlocProvider.of<EmployeeBlocService>(context).add(EmployeeCardAttendance(scanner: 'nfc', id: 'A4543400E200001965170147'));
//            Timer(Duration(milliseconds: 500), () {
//              BlocProvider.of<EmployeeBlocService>(context).add(EmployeeCardAttendance(scanner: 'nfc', id: '218A3000E200001965170273'));
//            });
//            Timer(Duration(seconds: 1), () {
//              BlocProvider.of<EmployeeBlocService>(context).add(EmployeeCardAttendance(scanner: 'nfc', id: 'A4543400E200001965170147'));
//            });
//          },
//          child: Text('test card'),
//        ),
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.credit_card),
                Text('$_deviceInfo',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            )
        ),
        Expanded(
          flex: 12,
          child: RawKeyboardListener(
              focusNode: _focusNode,
              autofocus: true,
              onKey: (RawKeyEvent event) {
                if ((event.runtimeType.toString() == 'RawKeyDownEvent') && (event.logicalKey.keyId == 1108101562648)) //Enter Key ID from keyboard
                {
                  _getIdCardInfo();
                }
              },
              child: CardScannerResult(),
          ),
        ),

      ],
    );
  }
}
