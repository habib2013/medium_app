import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medium_app/NetworkHandler.dart';
import 'package:medium_app/pages/HomePage.dart';

class CreateProfileScreen extends StatefulWidget {
  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool circular = false;
  final _globalKey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  var validatedInput = true;
  TextEditingController _fullnameEditingController = TextEditingController();
  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _professionEditingController = TextEditingController();
  TextEditingController _dateOfBirthEditingController = TextEditingController();
  TextEditingController _aboutEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Form(
            key: _globalKey,
            child: ListView(
              children: [
                imageProfile(),
                SizedBox(
                  height: 20.0,
                ),
                ourInputsForm("Full Name",_fullnameEditingController),
                SizedBox(
                  height: 20.0,
                ),
                ourInputsForm("Title",_titleEditingController),
                SizedBox(
                  height: 20.0,
                ),
                ourInputsForm("Profession",_professionEditingController),
                SizedBox(
                  height: 20.0,
                ),
                ourInputsForm("Date Of Birth",_dateOfBirthEditingController),
                SizedBox(
                  height: 20.0,
                ),
                ourInputsForm("About",_aboutEditingController),
                SizedBox(
                  height: 30.0,
                ),
                _submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ourInputsForm(String title, var ourController) {
    return TextFormField(
        controller: ourController,
        validator: (value){
            if (value.isEmpty || value.length <= 2) {setState(() {
                validatedInput = false;
              });
              return "❌ ${title} can\'t be empty";
            }
        },
        maxLines: title == 'About' ? 4 : 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: validatedInput ==  false ?  Colors.red : Colors.deepPurpleAccent,
            ),
          ) ,
//          prefixIcon: Icon(
//            title == "Full Name"
//                ? Icons.person
//                : title == 'Title'
//                    ? Icons.book
//                    : title == 'Profession'
//                        ? Icons.work
//                        : title == 'Date Of Birth'
//                            ? Icons.calendar_today
//                            : title == 'About' ? Icons.description : null,
//            color: Colors.deepPurpleAccent,
//          ),
          errorStyle: TextStyle(color: Colors.red),
          hintText: title,
          labelText: title,
        ));
  }

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
              padding: EdgeInsets.only(left: 0, top: 0, bottom: 5),
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
            Text('',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        setState(() {
          circular = true;
        });
        if (_globalKey.currentState.validate()) {
          Map<String,String> data = {
            "name" : _fullnameEditingController.text,
            "profession": _professionEditingController.text,
            "dob": _dateOfBirthEditingController.text,
            "title": _titleEditingController.text,
            "about": _aboutEditingController.text,
          };
            var response  = await networkHandler.post("profile/add", data);
            if(response.statusCode == 200 || response.statusCode == 201){
              if (_imageFile != null) {
                var imgResponse = await networkHandler.patchImage('profile/add/image', _imageFile.path);
                if (imgResponse.statusCode == 200 || imgResponse.statusCode == 201) {
                  setState(() {
                    circular = false;
                  });
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                }
              }  else {
                setState(() {
                  circular = false;
                });
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
              }
            }
          print(response.statusCode);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
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
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.deepPurple,
                  Colors.deepPurpleAccent,
                ])),
        child: circular ? CircularProgressIndicator() : Text(
          'Update Profile',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontFamily: 'Raleway'),
        ),
      ),
    );
  }

  Widget bottomSheet(){
    return Container(
    height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
      child: Column(
        children: [
          Text('Choose Profile Photo',style: TextStyle(color: Colors.black,fontSize: 20.0,fontFamily: 'Raleway'),),
          SizedBox(height: 20.0,),
          Expanded(
              flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatButton.icon(onPressed: (){takePhoto(ImageSource.camera);}, icon: Icon(Icons.camera,size: 30.0,color: Colors.deepPurpleAccent,), label: Text('Camera',style: TextStyle(color: Colors.deepPurpleAccent,fontSize: 15.0,fontFamily: 'Raleway'),)),
                FlatButton.icon(onPressed: (){takePhoto(ImageSource.gallery);}, icon: Icon(Icons.image,size: 30.0,color: Colors.deepPurpleAccent,), label: Text('Gallery',style: TextStyle(color: Colors.deepPurpleAccent,fontSize: 15.0,fontFamily: 'Raleway'),)),
//                FlatButton.icon(onPressed: (){null}, icon: Icon(Icons.clear,size: 30.0,color: Colors.red,), label: Text('Cancel',style: TextStyle(color: Colors.red,fontSize: 15.0,fontFamily: 'Raleway'),)),

              ],
            ),
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async{
      final pickedFile = await _picker.getImage(source: source);
      setState(() {
        _imageFile = pickedFile;
      });
  }

  imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            backgroundImage: _imageFile == null ? AssetImage('assets/thirdimg.png') : FileImage(File(_imageFile.path)),
            radius: 80,
          ),
          Positioned(
            top: 110,
            right: 20,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(context: context, builder: (builder) => bottomSheet());
              },
              child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
            ),
          ),
        ],
      ),
    );
  }
}
