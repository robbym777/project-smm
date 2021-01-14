import 'package:attendance_application/src/widget/report_widget/list_attendance_tab.dart';
import 'package:attendance_application/src/widget/report_widget/list_pending_attendance_tab.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> with TickerProviderStateMixin{
  List<Tab> tabList = List();
  TabController _tabController;

  @override
  void initState() {
    tabList.add(Tab(text:'Overview',));
    tabList.add(Tab(text:'Workouts',));
    _tabController = TabController(vsync: this, length: tabList.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).secondaryHeaderColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TabBar(
                  controller: _tabController,
                  indicatorColor: Theme.of(context).primaryColor,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(text:'List Absensi',),
                    Tab(text:'Pending Absensi',)
                  ]
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ListAttendanceTab(),
                PendingAttendanceTab(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
