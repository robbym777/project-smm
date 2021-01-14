import 'package:attendance_application/src/services/bloc_services/authentication/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/authentication/bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<AuthBlocService>(context),
      builder: (context, blocService) {
        if (blocService is Authenticated) {
          var data = blocService.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).secondaryHeaderColor
                  ),
                  child: CircleAvatar(
                    backgroundImage: data.personalInfo.photo != ''
                        ? NetworkImage(data.personalInfo.photo)
                        : AssetImage('assets/img/icons/icon-profile.png'),
                    radius: 50,
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(data.personalInfo.name, style: TextStyle(fontSize: 20, color: Colors.white)),
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
