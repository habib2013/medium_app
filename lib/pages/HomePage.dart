import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medium_app/screens/HomeScreen.dart';
import 'package:medium_app/profiles/ProfileScreen.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowCaseWidget(
        onStart: (index, key) {
          log('onStart: $index, $key');
        },
        onComplete: (index, key) {
          log('onComplete: $index, $key');
        },
        builder: Builder(builder: (context) => NewHomePage()),
        autoPlay: true,
        autoPlayDelay: Duration(seconds: 3),
        autoPlayLockEnable: true,
      ),
    );
  }
}

class NewHomePage extends StatefulWidget {
  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  GlobalKey _four = GlobalKey();
  GlobalKey _five = GlobalKey();

  final storage = new FlutterSecureStorage();




  int currentState = 0;
  bool isViewedAlready = false;
  List<Widget> widgets = [
    HomeScreen(),
    ProfileScreen(),
  ];
  List<String> titleString = ['Home','Profile'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    SharedPreferences preferences;

    displayShowCase() async{
      preferences = await SharedPreferences.getInstance();
      bool showCaseVisibilityStatus = preferences.getBool("displayShowCase");

      if (showCaseVisibilityStatus == null) {
        preferences.setBool("displayShowCase", false);
        return true;
      }
      return false;
    }

    displayShowCase().then((status) {
      if (status) {
        ShowCaseWidget.of(context)
            .startShowCase([_one, _two, _three, _four, _five]);
      }
    }

    );




    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(titleString[currentState],style: TextStyle(fontFamily: 'Raleway',color: Colors.blueGrey),),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Showcase(
              key: _one,
              title: 'Notifications',
              description: 'Your Notification shows here',
              shapeBorder: CircleBorder(),
              child:  Icon(Icons.notifications_none,color: Colors.blueGrey,),
            ),
            onPressed: null,
          ),
          IconButton(
            icon: Showcase(
              key: _two,
              title: 'Tap to search',
              description: 'Some amazing contents are here',
              showcaseBackgroundColor: Colors.blueAccent,
              textColor: Colors.white,
               child:  Icon(Icons.search,color: Colors.blueGrey,),
          ),
            onPressed: null,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Showcase(
        key: _three,
        title: 'Add an amazing Post',
        description: 'Click here to Start',
        shapeBorder: CircleBorder(),
        child:   FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: null,
          child: Icon(Icons.edit,color: Colors.blueGrey,),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  color: currentState == 0 ? Colors.blueGrey : Colors.blueGrey[300],
                  onPressed: (){
                    setState(() {
                      currentState = 0;
                    });
                  },
                  iconSize: 35.0,
                ),
                IconButton(

                  icon:
                  Showcase(
                    key: _five,
                    title: 'Notifications',
                    description: 'Your Notification shows here',
                    shapeBorder: CircleBorder(),
                    child:  Icon(Icons.person),

                  ),
                  color: currentState == 1 ? Colors.blueGrey : Colors.blueGrey[300],
                  onPressed:  (){
                    setState(() {
                      currentState = 1;
                    });
                  },
                  iconSize: 35.0,
                ),
              ],
            ),
          ),
        ),
      ),
      body: widgets[currentState],
    );
  }
}

