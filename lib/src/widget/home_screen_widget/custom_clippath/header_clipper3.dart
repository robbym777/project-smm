import 'package:attendance_application/src/widget/home_screen_widget/custom_clippath/custom_clip_1.dart';
import 'package:flutter/material.dart';

class HeaderWidget3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HeaderClipper3(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: double.infinity,
        color: Theme.of(context).accentColor,
      ),
    );
  }
}
