import 'package:attendance_application/src/services/bloc_services/authentication/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/authentication/bloc_state.dart';

import 'package:attendance_application/src/widget/profile_widget/address_row.dart';
import 'package:attendance_application/src/widget/profile_widget/profile_row_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalInfoCard extends StatelessWidget {
  final String title;
  PersonalInfoCard({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<AuthBlocService>(context),
      builder: (context, blocService) {
        if (blocService is Authenticated) {
          var data = blocService.data.personalInfo;
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
                        Icon(Icons.person),
                        SizedBox(width: 5),
                        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    )
                  ),
                  SizedBox(height: 20),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                          children: <Widget>[
                            ProfileData(title: 'Tempat Lahir',data: data.birthPlace),
                            ProfileData(title: 'Tanggal Lahir',data: data.birthDate),
                            ProfileData(title: 'Golongan Darah', data: data.bloodType),
                            AddressRow(title: 'Alamat', addressData: blocService.data.address)
                          ]
                      )
                  ),
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