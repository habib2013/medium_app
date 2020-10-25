import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medium_app/pages/HomePage.dart';
import 'package:medium_app/pages/TestShowCase.dart';
import 'package:medium_app/pages/ShimmerTest.dart';
import 'package:medium_app/pages/welcomePage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medium_app/profiles/MainProfile.dart';
import 'package:shimmer/shimmer.dart';
import 'package:medium_app/blogs/addBlog.dart';


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

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medium App',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        primaryColorLight: Colors.blue
      ),
      home: SplashScreen(),
    );
  }

}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget page = WelcomePage();
  final storage = new FlutterSecureStorage();
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page)));
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white54,])
        ),
        child: Center(
          child: Opacity(
            opacity: 0.8,
            child: Shimmer.fromColors(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                  ),
                  const Text(
                    'Spidium',
                    style: TextStyle(
                      fontSize: 40.0,fontFamily: 'Josefin Sans',
                      color: Colors.white,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              baseColor: Colors.blueGrey[200],
              highlightColor: Colors.black,
              loop: 3,
            ),
          ),
        ),
      ),
    );
  }
}

