import 'package:flutter/material.dart';

class DataScreen extends StatefulWidget {
  final Function dologOut;

  DataScreen({this.dologOut});
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.center,
        height: 200,
        width: 200,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Hello Data',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          GestureDetector(
            onTap: widget.dologOut,
            child: Text(
              'Sign Out Now',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        ]));
  }
}
