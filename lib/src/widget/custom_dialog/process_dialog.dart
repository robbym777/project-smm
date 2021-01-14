import 'package:flutter/material.dart';

class ProcessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SimpleDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 30),
        backgroundColor:  Theme.of(context).primaryColor,
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).secondaryHeaderColor),
                ),
                SizedBox(height: 10),
                Text('Sedang memproses...', style: TextStyle(color: Colors.white))
              ],
            ),
          )
        ],
      ),
    );
  }
}
