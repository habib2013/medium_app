import 'package:flutter/material.dart';
import 'package:medium_app/pages/HomePage.dart';
import 'package:medium_app/pages/Onboarding.dart';
import 'package:medium_app/pages/welcomePage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medium_app/profiles/MainProfile.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = WelcomePage();
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
//    var token  = storage.delete(key: "token");
    var token  = storage.read(key: "token");

  if (token != null) {
      setState(() {
        page = HomePage();
      });
    }
    else {
      setState(() {
        page = WelcomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medium App',
      home: MainProfile(),
    );
  }
}
