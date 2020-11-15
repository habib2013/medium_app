import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medium_app/NetworkHandler.dart';
import 'package:medium_app/models/profileModel.dart';
import 'package:flutter_offline/flutter_offline.dart';

class MainProfile extends StatefulWidget {
  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  bool circular = true;
  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel();

  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get('profile/getData');
    setState(() {
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> output = json.decode(response.body);
        profileModel = ProfileModel.fromJson(output["data"]);
      }
//        print(profileModel.username ?? 'Nothing here');
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: circular
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                head(),
                Divider(
                  thickness: 1.0,
                ),
            otherDetails("About","Hello I am Oladosu Tayo"),
                settingWidgets(context),
              ],
            ),
    );
  }

  Widget head() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            '${profileModel.username}\'s Profile',
            style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 23,
                fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              height: 100,
              child: CircleAvatar(
                backgroundColor: Colors.purpleAccent,
                radius: 50,
                backgroundImage:
                    NetworkHandler().getImage(profileModel.username),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Center(
            child: Text(
              profileModel.name ?? "",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Josefin Sans',
                  fontSize: 19),
            ),
          ),
          SizedBox(height: 5.0),
          Center(
              child: Text(
            profileModel.profession ?? '',
            style: TextStyle(color: Colors.blueGrey),
          )),
        ],
      ),
    );
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
      child: Center(
        child: Row(
          children: [
            Container(
              width: 100,
              child: Column(
                children: [
                  Text('200',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,fontFamily: 'Josefin Sans',color: Colors.blueGrey),),
                  SizedBox(height: 6,),
                  Text('Reviews',style: TextStyle(fontFamily: 'Josefin Sans',fontSize: 12),)
                ],
              ),
            ),

            SizedBox(
              height: 40.0,
              child: VerticalDivider(
                thickness: 2.0,
              ),
            ),
            Container(
              width: 100,
              child: Column(
                children: [
                  Text('145',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,fontFamily: 'Josefin Sans',color: Colors.blueGrey),),
                  SizedBox(height: 6,),
                  Text('Followers',style: TextStyle(fontFamily: 'Josefin Sans',fontSize: 12),)
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
              child: VerticalDivider(
                thickness: 2.0,
              ),
            ),
            Container(
              width: 100,
              child: Column(
                children: [
                  Text('176',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,fontFamily: 'Josefin Sans',color: Colors.blueGrey),),
                  SizedBox(height: 6,),
                  Text('Following',style: TextStyle(fontFamily: 'Josefin Sans',fontSize: 12),)
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget settingWidgets(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
            InkWell(
              onTap: () => {
                null
                },
              child: Container(
                height: 50.0,
                width: 140.0,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(5),

                ),
                child: Center(
                  child: Text('Edit Profile', style: TextStyle(color: Colors.white,fontFamily: 'Josefin Sans',fontSize: 16),),
                ),
              ),
            ),
              SizedBox(width: 50,),
              InkWell(
                onTap: () => {
                  null
                },
                child: Container(
                  height: 50.0,
                  width: 140.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.blueGrey
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),

                  ),
                  child: Center(
                    child: Text('Settings', style: TextStyle(color: Colors.blueGrey,fontFamily: 'Josefin Sans',fontSize: 16),),
                  ),
                ),
              ),
            ],
          ),

        ],
      )
    );
  }
}
