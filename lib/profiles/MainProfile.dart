import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medium_app/NetworkHandler.dart';
import 'package:medium_app/models/profileModel.dart';

class MainProfile extends StatefulWidget {
  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  bool circular = true;
  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel();
  void initState(){
    super.initState();
    fetchData();
  }
  void fetchData() async{
    var response = await networkHandler.get('profile/getData');
    setState(() {
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String,dynamic> output = json.decode(response.body);
        profileModel = ProfileModel.fromJson(output["data"]);
      }
//        print(profileModel.username ?? 'Nothing here');
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: null,
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white10,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: null,
            color: Colors.black,
          )
        ],
      ),
      body: circular ? Center(child: CircularProgressIndicator()) : ListView(
        children: [
          head(),
          Divider(
            thickness: 1.0,
          ),
//            otherDetails("About","Hello I am Oladosu Tayo"),
        getFollow(context),
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
            child: CircleAvatar(
              backgroundColor: Colors.purpleAccent,
              radius: 50,
                backgroundImage: NetworkHandler().getImage(profileModel.username),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            profileModel.name ?? "",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
                fontSize: 19),
          ),
          SizedBox(height: 5.0),
          Text(profileModel.profession ?? ''),
        ],
      ),
    );
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label :",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget getFollow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(

                children: [
                  Text(
                    " 14  ",
                    style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
                  ),
                  Text(' Following')
                ],
              ),

              SizedBox(height: 40.0,width: MediaQuery.of(context).size.width / 3.5,child: VerticalDivider(thickness: 2.0,),),
              Row(

                children: [
                  Text(
                    "17  ",
                    style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
                  ),
                  Text(' Followers',)
                ],

              ),
              Divider(thickness: 3.0,)
            ],
          ),
        ],
      ),
    );
  }
}
