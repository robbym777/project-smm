import 'package:attendance_application/src/screens/home_screen.dart';
import 'package:attendance_application/src/screens/profile_screen.dart';
import 'package:attendance_application/src/screens/attendance_screen.dart';
import 'package:attendance_application/src/screens/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

String API_URL = 'http://ec2-18-136-210-143.ap-southeast-1.compute.amazonaws.com:3003';

final List<Map<String, dynamic>> pages = [
  {'page': HomeScreen(), 'title': 'Beranda', 'icon': LineIcons.home},
  {'page': ReportScreen(), 'title': 'Laporan', 'icon': LineIcons.file_text_o},
  {'page': AttendanceScreen(), 'title': 'Absensi', 'icon': Icons.assignment_ind},
  {'page': ProfileScreen(), 'title': 'Profil', 'icon': LineIcons.user},
];

String qrScanner = 'qrcode';
String cardScanner = 'cardId';

Color hourEntryColor = Colors.green[500];
MaterialAccentColor hourOutColor = Colors.redAccent;

class MainButtonMaterial {
  static double buttonSize = 10;
}