import 'package:flutter/material.dart';

class ShowSingle extends StatefulWidget {
  @override
  _ShowSingleState createState() => _ShowSingleState();
}

class _ShowSingleState extends State<ShowSingle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Hello"),
        ),
      ),
    );
  }
}
