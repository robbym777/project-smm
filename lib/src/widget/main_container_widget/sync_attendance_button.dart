import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_state.dart';
import 'package:attendance_application/src/services/db_service/db_service.dart';
import 'package:attendance_application/src/utils/pop_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class SyncAttendanceButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<OfflineBlocService>(context),
      builder: (context, blocService) {
        if (blocService is ListPendingAttendance) {
           return FloatingActionButton.extended(
               onPressed: () {
                 PopDialog.showProcessDialog(context);
                 context.bloc<EmployeeBlocService>().add(SubmitPendingAttendance());
               },
               label: Text('Unggah absensi'),
               icon: Icon(LineIcons.cloud_upload)
           );
        }
        if (blocService is ListPendingIsNull) {
          return Container();
        }
        return Container();
      },
    );
  }
}
