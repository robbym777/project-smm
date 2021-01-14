import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_event.dart';
import 'package:attendance_application/src/utils/pop_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QrScannerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton.icon(
      onPressed: () async {
        await scanner.scan().then((String result) {
          PopDialog.showLoadingDialog(context);
          context.bloc<EmployeeBlocService>().add(EmployeeQRAttendance(scanner: 'qrcode', id: result));
        });
      },
      padding: EdgeInsets.all(10),
      icon: Icon(LineIcons.qrcode, size: 30),
      label: Text('Scan QR Code'),
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Icon(LineIcons.qrcode, size: 50),
//          Text('Scan QR Code')
//        ],
//      ),
    );
  }
}
