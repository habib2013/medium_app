import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medium_app/NetworkHandler.dart';
import 'package:medium_app/pages/HomePage.dart';
import 'lognPage.dart';
import '../Widget/bezierContainer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool vis = true;
  final _globalKey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();

  TextEditingController _usernameEditingController = TextEditingController();
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(var editController,String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//          Text(
//            title,
//            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: editController,
              validator: (value) {
                if (value.isEmpty) {
                  return "${title} cannot be empty";
                }
                if (title == 'Email' && !value.contains('@')) {
                  return 'Email is Invalid';
                }
                if ((title == 'Password') && value.length <= 8) {
                  return 'Password can\'t be less than 8';
                }
              },

              obscureText: isPassword && vis,
              decoration: InputDecoration(
                errorText: validate && title != 'Username' ? null : errorText,
                  prefixIcon: title == 'Email id' ? Icon(FeatherIcons.mail) : title == 'Username' ? Icon(FeatherIcons.user) : Icon(FeatherIcons.lock),
                  suffixIcon: isPassword == true
                      ? IconButton(
                          icon: vis
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              vis = !vis;
                            });
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),

                  filled: true)
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async
      {
        setState(() {
          circular = true;
        });
        await checkUser();
        if (_globalKey.currentState.validate() && validate) {
          print('Data Sent to server ');

          Map<String,String> data = {
            "username" : _usernameEditingController.text,
            "email": _emailEditingController.text,
            "password": _passwordEditingController.text,

          };
       var responseregister =   await networkHandler.post("user/register",data);

         if (responseregister.statusCode == 200 || responseregister == 201) {
           Map<String,String> data = {
             "username" : _usernameEditingController.text,
             "password": _passwordEditingController.text,
           };
           var response = await networkHandler.post("user/login", data);
           if (response.statusCode == 200 || response.statusCode == 201 ) {
             Map<String,dynamic> output = json.decode(response.body);
             print(output['token']);
             await storage.write(key: "token", value: output['token']);
             setState(() {
               validate = true;
               circular = false;
             });
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);

           }

         }

          setState(() {
            circular = false;
          });
          print(data);
        }
        else{
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                 colors: [Colors.blueGrey[300], Colors.blueGrey[500],])),
        child: circular ? CircularProgressIndicator() : Text(
          'Register Now',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontFamily: 'Josefin Sans'),
        ),
      ),
    );
  }

  checkUser() async{

    if (_usernameEditingController.text.length == 0 ) {
      setState(() {
        circular = false;
        validate = false;
        errorText = 'Username can\'t be empty';
      });
    }
    else{
      var response = await networkHandler.get('user/checkusername/${_usernameEditingController.text}');
//     var getSubs = await networkHandler.get('');

     if (response.statusCode == 200 || response.statusCode == 201) {
       Map output = json.decode(response.body);
       print(output['Status']);

       if (output['Status']) {
         setState(() {
           circular = false;
           validate = false;
           errorText = 'User already exists';
         }
         );
       }
       else{
         validate = true;
       }
     }



    }
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,fontFamily: 'Josefin Sans'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Spi',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.blueGrey,
            fontFamily: 'Josefin Sans',
          ),
          children: [
            TextSpan(
              text: 'di',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 30,
                  fontFamily: 'Josefin Sans'),
            ),
            TextSpan(
              text: 'um',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 30,
                  fontFamily: 'Josefin Sans'),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField(_usernameEditingController,"Username"),
        _entryField(_emailEditingController,"Email id"),
        _entryField(_passwordEditingController,"Password", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _globalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(
                        height: 50,
                      ),
                      _emailPasswordWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      _submitButton(),
                      SizedBox(height: height * .14),
                      _loginAccountLabel(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
