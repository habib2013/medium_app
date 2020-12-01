import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medium_app/NetworkHandler.dart';
import 'package:medium_app/customWidgets/OverlayCard.dart';
import 'package:medium_app/pages/HomePage.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

class AddBlog extends StatefulWidget {
  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  var validatedInput = true;
  TextEditingController _blogtitle = TextEditingController();
  TextEditingController _blogBody = TextEditingController();
  TextEditingController _category = TextEditingController();
  TextEditingController _readTime = TextEditingController();
  bool circular = false;
  final _globalKey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();


  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();



  @override
  Widget build(BuildContext context) {

    String _currentSelectedValue = "Medical";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.clear, size: 30.0, color: Colors.blueGrey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Text(
          'Add Blog',
          style: TextStyle(
              fontFamily: 'Josefin Sans', fontSize: 30.0, color: Colors.blueGrey),
        ),
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: () {
                if (_imageFile != null && _globalKey.currentState.validate()) {
                  showModalBottomSheet(
                      context: context,
                      builder: ((builder) => OverlayCard(
                        imageFile: _imageFile,
                        title: _blogtitle.text,
                        body: _blogBody.text,
                      )
                      )
                  );
                }

              },
              child: Text(
                'Preview',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blueGrey[400],
                    fontFamily: 'Josefin Sans',
                    fontWeight: FontWeight.bold),
              )
          
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 55.0),
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              _ourInputsForm("Image & Blog Title", _blogtitle),
              SizedBox(
                height: 10,
              ),
              _ourInputsForm("Body", _blogBody),
              SizedBox(
                height: 10,
              ),

              Text('Category',style:TextStyle(fontFamily: 'Josefin Sans',
                  color: Colors.black,fontSize: 18)),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 60,
                child: FormField<String>(

                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(

                          labelStyle: TextStyle(color: Colors.blueAccent, fontSize: 12.0),
                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
                          hintText: 'Please select expense',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                      isEmpty: _currentSelectedValue == '',
                      child: DropdownButtonHideUnderline(
                        child: DropDown<String>(
                          items: <String>["Code challenge", "Start up", "AI trends","Algorithms","Hacking"],
                          initialValue: "Start up",
                          hint: Text("Select Category"),
                          onChanged: (String newValue){
                            setState(() {
                              _currentSelectedValue = newValue;
                              print(_currentSelectedValue);
                              _category.text = _currentSelectedValue;
                            });
                          },
                        ),

                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),

              Text('Read Time',style:TextStyle(fontFamily: 'Josefin Sans',
                  color: Colors.black,fontSize: 18)),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 60,
                child: FormField<String>(

                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.blueAccent, fontSize: 12.0),
                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
                          hintText: 'Please select expense',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                      isEmpty: _currentSelectedValue == '',
                      child: DropdownButtonHideUnderline(
                        child: DropDown<String>(
                          items: <String>["2mins", "3mins", "4mins","5mins","6mins","7mins"],
                          initialValue: "3mins",
                          hint: Text("Select Category"),
                          onChanged: (String newValue){
                            setState(() {
                              _currentSelectedValue = newValue;
                              print(_currentSelectedValue);
                              _readTime.text = _currentSelectedValue;
                            });
                          },
                        ),

                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ourInputsForm(String title, var ourController) {
    return TextFormField(
      controller: ourController,
      validator: (value) {
        if (value.isEmpty || value.length <= 2) {
          setState(() {
            validatedInput = false;
          });
          return "❌ ${title} can\'t be empty";
        }
      },
      maxLines: title == 'Body' ? 4 : 1,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: validatedInput == false
                  ? Colors.red
                  : Colors.deepPurpleAccent,
            ),
          ),
          errorStyle: TextStyle(color: Colors.red),
          hintText: title,
          labelText: title,
          prefixIcon: title == 'Image & Blog Title'
              ? IconButton(
                  onPressed: () {
                    takeCoverPhoto(ImageSource.gallery);

                  },
                  icon: Icon(
                    FeatherIcons.image,
                    color: Colors.blueGrey,
                  ),
                )
              : null),
      maxLength: title == 'Body' ? 400 : 60,
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        setState(() {
          circular = true;
        });
        if (_globalKey.currentState.validate()) {
          Map<String, String> data = {
            "title": _blogtitle.text,
            "body": _blogBody.text,
            "category": _category.text,
            "readTime": _readTime.text,
            "datePublished": '12/10/2020'
          };
          var response = await networkHandler.post("blogPost/Add", data);
          if (response.statusCode == 200 || response.statusCode == 201) {
//            print(response.body.)
            Map<String, dynamic> map = json.decode(response.body);
            print(map["data"]);
            String postId = map["data"]["_id"];
            print(postId);
            if (_imageFile != null) {
              var imgResponse = await networkHandler.patchImage('blogPost/add/coverImage/${postId}', _imageFile.path);
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
              //Next One shouldnt go anywhere but show an erroor message
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
            }


//            Navigator.pushAndRemoveUntil(
//                context,
//                MaterialPageRoute(builder: (context) => HomePage()),
//                (route) => false);
          }
          print(data);
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
                  Colors.blueGrey,
                  Colors.blueGrey[300],
                ])),
        child: Center(
          child: Row(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [

              Text(
                'Post Now',
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontFamily: 'Josefin Sans'),
              ),

              SizedBox(width: 50,),
              Icon(FeatherIcons.arrowRight,color: Colors.white,),
            ],
          ),
        ),
      ),
    );
  }

  void takeCoverPhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }


}
