import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class HomeScreenHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Text(DateFormat('EEEE, dd LLL yyyy').format(DateTime.now()),
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          Text('Selamat datang di aplikasi SMM Attendance',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          ),
//          DigitalClock(
//            is24HourTimeFormat: true,
//            digitAnimationStyle: Curves.easeInQuart,
//            hourMinuteDigitDecoration: BoxDecoration(
//              color: Colors.white,
//              borderRadius: BorderRadius.circular(5)
//            ),
//            areaDecoration: BoxDecoration(
//              color: Colors.transparent
//            ),
//            hourMinuteDigitTextStyle: TextStyle(
//              color: Colors.black,
//              fontSize: 50,
//              fontFamily: 'Arial'
//            ),
//            secondDigitTextStyle: TextStyle(
//              fontSize: 25,
//              fontFamily: 'Arial'
//            ),
//          )
        ],
      ),
    );
  }
}
