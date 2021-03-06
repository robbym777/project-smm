import 'package:attendance_application/src/widget/login_widget/custom_clip_path.dart';
import 'package:flutter/material.dart';

class LoginHeaderStyle2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: LoginClipper(),
      child: Container(
        height: MediaQuery.of(context).size.height*0.75,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }
}
