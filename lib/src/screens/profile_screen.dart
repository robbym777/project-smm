import 'package:attendance_application/src/services/bloc_services/authentication/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/authentication/bloc_event.dart';

import 'package:attendance_application/src/widget/profile_widget/contact_info_card.dart';
import 'package:attendance_application/src/widget/profile_widget/profile_info_card.dart';
import 'package:attendance_application/src/widget/profile_widget/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.bloc<AuthBlocService>().add(CheckAuthentication());
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: ProfileHeader(),
              ),
              PersonalInfoCard(title: 'Personal Info'),
              ContactInfoCard(title: 'Contact Info')
            ],
          ),
        ),
      ),
    );
  }
}
