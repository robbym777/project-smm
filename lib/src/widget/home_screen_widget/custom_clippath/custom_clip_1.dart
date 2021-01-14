import 'package:flutter/material.dart';

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0, size.height*0.5);
    path.quadraticBezierTo(size.width*0.25, size.height*0.45, size.width*0.4, size.height*0.6);
    path.quadraticBezierTo(size.width*0.6, size.height*0.8, size.width, size.height*0.6);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

class HeaderClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0, size.height - 40);
    path.lineTo(size.width/2, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

class HeaderClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0, size.height*0.6);
    path.quadraticBezierTo(size.width*0.25, size.height*0.5, size.width*0.4, size.height*0.65);
    path.quadraticBezierTo(size.width*0.6, size.height*0.8, size.width, size.height*0.6);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}