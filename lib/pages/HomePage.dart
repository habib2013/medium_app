import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medium_app/Widget/bezierContainer.dart';
import 'package:medium_app/blogs/addBlog.dart';
import 'package:medium_app/models/profileModel.dart';
import 'package:medium_app/pages/welcomePage.dart';
import 'package:medium_app/screens/HomeScreen.dart';
import 'package:medium_app/profiles/ProfileScreen.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medium_app/NetworkHandler.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";


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
  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel();

  int currentState = 0;
  bool isViewedAlready = false;
  List<Widget> widgets = [
    HomeScreen(),
    ProfileScreen(),
  ];
  List<String> titleString = ['Home', 'Profile'];


  void checkProfile() async{
    var response = await networkHandler.get('profile/checkProfile');
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String,dynamic> output = json.decode(response.body);

      if (output['status'] == true) {

        setState(() {
          profilePhoto = Column(
            children:[ CircleAvatar(
              backgroundColor: Colors.purpleAccent,
              radius: 50,
              backgroundImage: NetworkHandler().getImage(output['username']),
            ),
            SizedBox(height: 4.0,),
            Text(output['username'],style: TextStyle(fontFamily: 'Josefin Sans'),),
            ]
          );
        });
      }
      else {
        setState(() {
          profilePhoto = Column(
            children: [Container(
              height:100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.black,
              ),
            ),
              Text(output['username']),
            ],
          );
        });
      }

    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkProfile();
  }

  Widget profilePhoto =  Container(
    height:100,
    width: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50.0),
      color: Colors.black,
    ),
  );




  @override
  Widget build(BuildContext context) {
    SharedPreferences preferences;
    final height = MediaQuery.of(context).size.height;
    displayShowCase() async {
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
    });


    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  profilePhoto,
                  SizedBox(height: 10,),

                ],
              ),
            ),

            ListTile(
              title: Text('All Posts',style: TextStyle(fontFamily: 'Josefin Sans',color: Colors.black),),
              leading: Icon(FeatherIcons.grid),
              onTap: (){

              },
            ),
            ListTile(
              title: Text('New Story',style: TextStyle(fontFamily: 'Josefin Sans',color: Colors.black),),
              leading: Icon(FeatherIcons.edit),
              onTap: (){

              },
            ),

            ListTile(
              title: Text('Feedbacks',style: TextStyle(fontFamily: 'Josefin Sans',color: Colors.black),),
              leading: Icon(FeatherIcons.mic),
              onTap: (){

              },
            ),
            ListTile(
              title: Text('Logout',style: TextStyle(fontFamily: 'Josefin Sans',color: Colors.black),),
              leading: Icon(FeatherIcons.logOut),
              onTap: (){
                logout();
              },
            ),

          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          titleString[currentState],
          style: TextStyle(fontFamily: 'Josefin Sans', color: Colors.blueGrey),
        ),
        centerTitle: false,

        iconTheme: new IconThemeData(color: Colors.blueGrey),
        actions: [
          IconButton(
            icon: Showcase(
              key: _one,
              title: 'Notifications',
              description: 'Your Notification shows here',
              shapeBorder: CircleBorder(),
              child: Icon(
                FeatherIcons.bell,
                color: Colors.blueGrey,
              ),
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
              child: Icon(
                FeatherIcons.search,
                color: Colors.blueGrey,
              ),
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
        child: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddBlog()));
          },
          child: Icon(
           FeatherIcons.edit2,
            color: Colors.white,
          ),
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
                  icon: Icon(FeatherIcons.grid),
                  color: currentState == 0
                      ? Colors.blueGrey
                      : Colors.blueGrey[300],
                  onPressed: () {
                    setState(() {
                      currentState = 0;
                    });
                  },
                  iconSize: 35.0,
                ),
                IconButton(
                  icon: Showcase(
                    key: _five,
                    title: 'Notifications',
                    description: 'Your Notification shows here',
                    shapeBorder: CircleBorder(),
                    child: Icon(FeatherIcons.user),
                  ),
                  color: currentState == 1
                      ? Colors.blueGrey
                      : Colors.blueGrey[300],
                  onPressed: () {
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

  void logout() async{
    await storage.deleteAll();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomePage()), (route) => false);
  }

}
