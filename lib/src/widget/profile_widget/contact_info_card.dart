import 'package:attendance_application/src/services/bloc_services/authentication/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/authentication/bloc_state.dart';

import 'package:attendance_application/src/widget/profile_widget/profile_row_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactInfoCard extends StatelessWidget {
  final String title;
  ContactInfoCard({this.title});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<AuthBlocService>(context),
      builder: (context, blocService) {
        if (blocService is Authenticated) {
          var data = blocService.data;
          return Card(
            elevation: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                      width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.contact_mail),
                          SizedBox(width: 5),
                          Text(title, style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          )),
                        ],
                      )),
                  SizedBox(height: 10),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(children: <Widget>[
                        ProfileData(title: 'Email', data: data.contactInfo.email),
                        ProfileData(title: 'Nomor Telephone', data: data.contactInfo.phoneNumber),
                        ProfileData(title: 'Simper/ID Card', data: data.workInfo.simperIdCard),
                      ])),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
