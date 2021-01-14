
import 'package:attendance_application/src/services/bloc_services/socket_service/bloc_bloc.dart';
import 'package:attendance_application/src/services/bloc_services/socket_service/bloc_state.dart';
import 'package:attendance_application/src/services/bloc_services/submit_pending/bloc_event.dart';
import 'package:attendance_application/src/services/bloc_services/submit_pending/bloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ConnectionIndicator extends StatefulWidget {
  @override
  _ConnectionIndicatorState createState() => _ConnectionIndicatorState();
}

class _ConnectionIndicatorState extends State<ConnectionIndicator> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<SocketBlocService>(context),
      builder: (context, blocService) {
        if (blocService is Connected) {
          context.bloc<SubmitPendingBloc>().add(SubmitPendingAttendance());
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    show = !show;
                  });
                },
                padding: EdgeInsets.zero,
                tooltip: blocService.status,
                icon: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: Icon(Icons.swap_vertical_circle, color: Colors.green)
                ),
              ),
              AnimatedContainer(
                width: show ? 90.0 : 0.0,
                alignment: Alignment.centerLeft,
                duration: Duration(milliseconds: 250),
                child: Text(blocService.status,
                  style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
              ),
            ],
          );
        }
        if (blocService is Disconnected) {
          return Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    show = !show;
                  });
                },
                tooltip: blocService.status,
                icon: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: Icon(Icons.swap_vertical_circle, color: Colors.red)
                ),
              ),
              AnimatedContainer(
                width: show ? 100.0 : 0.0,
                alignment: Alignment.centerRight,
                duration: Duration(milliseconds: 500),
                child: Text(blocService.status, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
              ),
            ],
          );
        }
        if (blocService is Reconnecting) {
          return Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    show = !show;
                  });
                },
                tooltip: blocService.status,
                icon: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: Icon(Icons.swap_vertical_circle, color: Colors.blue)
                ),
              ),
              AnimatedContainer(
                width: show ? 100.0 : 0.0,
                alignment: Alignment.centerRight,
                duration: Duration(milliseconds: 500),
                child: Text(blocService.status, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
              ),
            ],
          );
        }
        return IconButton(
          onPressed: () {},
          tooltip: 'connecting to server',
          icon: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Icon(Icons.swap_vertical_circle, color: Colors.grey)
          ),
        );
      },
    );
  }
}
