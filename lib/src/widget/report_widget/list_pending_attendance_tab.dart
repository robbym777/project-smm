import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/submit_pending/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/submit_pending/bloc_state.dart';
import 'package:attendance_application/src/utils/pop_dialog.dart';
import 'package:attendance_application/src/widget/main_container_widget/sync_attendance_button.dart';
import 'package:attendance_application/src/widget/report_widget/custom_filter_tab.dart';
import 'package:attendance_application/src/widget/report_widget/display_pending_attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class PendingAttendanceTab extends StatefulWidget {
  @override
  _PendingAttendanceTabState createState() => _PendingAttendanceTabState();
}

class _PendingAttendanceTabState extends State<PendingAttendanceTab> {
  DateTime chosenDate;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<SubmitPendingBloc>(context),
      listener: (context, blocService) {
        if (blocService is SubmitPendingSuccess) {
//          Navigator.of(context).pop();

          context.bloc<OfflineBlocService>().add(PendingAttendance());
          Fluttertoast.showToast(
              msg: 'Upload semua pending absensi berhasil ',
              backgroundColor: Colors.black38,
              gravity: ToastGravity.CENTER
          );
        }
        if (blocService is SubmitPendingFailed) {
//          Navigator.of(context).pop();

          context.bloc<OfflineBlocService>().add(PendingAttendance());
          Fluttertoast.showToast(
              msg: 'Gagal, tidak ada koneksi ',
              backgroundColor: Colors.black38,
              gravity: ToastGravity.CENTER
          );
        }
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CustomFilterTab(
                  getAll: () {
                    context.bloc<OfflineBlocService>().add(PendingAttendance());
                  },
                  pickDate: (val) {
                    context.bloc<OfflineBlocService>().add(PendingAttendanceByDate(
                        date: DateFormat('yyyy-MM-dd').format(val))
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
                flex: 16,
                child: DisplayPendingAttendance()
            ),
          ],
        ),
//        floatingActionButton: SyncAttendanceButton(),
      ),
    );
  }
}
