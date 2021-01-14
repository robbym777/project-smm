import 'package:attendance_application/src/screens/list_employee_screen.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/employee_service/bloc_state.dart';
import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/offline_service/bloc_event.dart';
import 'package:attendance_application/src/utils/app_data.dart';
import 'package:attendance_application/src/utils/pop_dialog.dart';
import 'package:attendance_application/src/widget/custom_dialog/update_dialog.dart';
import 'package:attendance_application/src/widget/home_screen_widget/home_menu_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: BlocProvider.of<EmployeeBlocService>(context),
          listener: (context, blocService) {
            if (blocService is UpdateMessage) {
              Navigator.of(context).pop();

              PopDialog.showUpdateDialog(context, UpdateDialog(
                title: blocService.status,
                isUpdate: blocService.isUpdate,
              ));
            }
            if (blocService is NoConnection) {
              Navigator.of(context).pop();

              PopDialog.showNoInternetConnection(context);
            }
          },
        ),
        BlocListener(
          bloc: BlocProvider.of<EmployeeBlocService>(context),
          listener: (context, blocService) {
            if (blocService is UpdateSuccess) {
              Navigator.of(context).pop();

              PopDialog.showUpdateSuccess(context);

              context.bloc<OfflineBlocService>().add(GetLocalHistory());
            }
            if (blocService is UpdateFailed) {
              Navigator.of(context).pop();

              PopDialog.showNoInternetConnection(context);
            }
          },
        )
      ],
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            MenuButton(
              onClick: () {
                PopDialog.showProcessDialog(context);
                context.bloc<EmployeeBlocService>().add(CheckUpdateEmployee());
              },
              label: 'Cek Pembaruan',
              icon: LineIcons.cloud_upload,
            ),
            MenuButton(
              onClick: () {
                Navigator.of(context).pushNamed(ListEmployeeScreen.ROUTE_NAME);
              },
              label: 'Daftar Karyawan',
              icon: LineIcons.users,
            ),
          ],
        ),
      ),
    );
  }
}
