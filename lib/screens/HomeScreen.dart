import 'package:flutter/material.dart';
import 'package:medium_app/Widget/PostsList.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return PostsList();
  }
}
