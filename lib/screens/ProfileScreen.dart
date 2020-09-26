import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medium_app/screens/CreateProfileScreen.dart';
import 'package:medium_app/NetworkHandler.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
NetworkHandler networkHandler = NetworkHandler();
Widget page = CircularProgressIndicator();

  @override
  void initState(){
    checkProfile();
    super.initState();

  }
 void checkProfile() async{
    var response = await networkHandler.get('profile/checkProfile');
    Map<String,dynamic> output = json.decode(response.body);
    print(output['status']);
    if (output['status']) {
      setState(() {
        page = showProfile();
      });
    }
    else {
      setState(() {
        page = button();
      });

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: page,

      ),
    );
  }

  Widget showProfile(){
    return Center(
      child: Column(
        children: [
          Text('Profile is available'),
        ],
      ),
    );
  }

  Widget button(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Text('Tap button to add profile',style: TextStyle(color: Colors.orange),),
      SizedBox(height: 30.0,),
        InkWell(
          onTap: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateProfileScreen()))
          },
          child: Container(
            height: 40.0,
            width: 140.0,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10),

            ),
            child: Center(
              child: Text('Add Profile', style: TextStyle(color: Colors.white54),),
            ),
          ),
        )

      ],

    );
  }

}
