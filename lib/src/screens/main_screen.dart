import 'package:attendance_application/src/utils/app_data.dart';
import 'package:attendance_application/src/widget/main_container_widget/connection_indicator.dart';
import 'package:attendance_application/src/widget/main_container_widget/sync_attendance_button.dart';
import 'package:attendance_application/src/widget/profile_widget/menu_button.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const ROUTE_NAME = '/main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedPageIndex = 0;
  void _onSelectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: Icon(pages[_selectedPageIndex]['icon'], size: 30,), backgroundColor: Colors.white, maxRadius: 10),
        ),
        title: Text(pages[_selectedPageIndex]['title']),
        centerTitle: true,
        actions: <Widget>[
          ConnectionIndicator(),
          pages[_selectedPageIndex]['title'] == 'Profil'
              ? MenuButton()
              : Container(),
        ],
      ),
      body: pages[_selectedPageIndex]['page'],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.3))
            ],
            borderRadius: BorderRadius.circular(100)
        ),
        margin: EdgeInsets.all(5),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: GNav(
                gap: 8,
                activeColor: Theme.of(context).secondaryHeaderColor,
                color: Theme.of(context).accentColor,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 500),
                tabBackgroundColor: Colors.grey[800],
                selectedIndex: _selectedPageIndex,
                onTabChange: _onSelectPage,
                tabs: pages.map((listPage) {
                  return GButton(
                    icon: listPage['icon'],
                    text: listPage['title'],
                    backgroundColor: Colors.red,
                  );
                }).toList()),
          ),
        ),
      )
    );
  }
}
