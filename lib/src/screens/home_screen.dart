import 'package:attendance_application/src/widget/home_screen_widget/custom_clippath/header_clipper1.dart';
import 'package:attendance_application/src/widget/home_screen_widget/custom_clippath/header_clipper2.dart';
import 'package:attendance_application/src/widget/home_screen_widget/custom_clippath/header_clipper3.dart';
import 'package:attendance_application/src/widget/home_screen_widget/home_menu.dart';
import 'package:attendance_application/src/widget/home_screen_widget/home_screen_header.dart';
import 'package:attendance_application/src/widget/home_screen_widget/local_history.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            HeaderWidget3(),
//            HeaderWidget2(),
            HeaderWidget(),
            Column(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        Expanded(flex: 2, child: HomeScreenHeader()),
                        Expanded(flex: 1, child: HomeMenu()),
                      ],
                    )
                ),
                Expanded(flex: 2, child: LocalHistoryTab())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
