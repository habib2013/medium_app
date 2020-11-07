import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medium_app/NetworkHandler.dart';

class ShowSingle extends StatefulWidget {
  final String blogId;
  ShowSingle({ Key key, this.blogId }): super(key: key);
  @override
  _ShowSingleState createState() => _ShowSingleState();


}

class _ShowSingleState extends State<ShowSingle> {
  NetworkHandler networkHandler = NetworkHandler();

    @override
  void initState() {
    // TODO: implement initState
      getBlogDetails();
    super.initState();
  }
    void getBlogDetails() async{
      String blogId = widget.blogId;
     var response = await networkHandler.get('blogPost/'+ blogId);
//     print(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> map = json.decode(response.body);
        Map<String,dynamic> myblogData = map["data"];
        print(myblogData);
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        child: Center(
          child: Text(widget.blogId ?? 'Nothing'),
        ),
      ),
    );
  }
}
