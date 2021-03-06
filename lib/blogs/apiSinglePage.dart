import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medium_app/NetworkHandler.dart';

class ApiSinglePage extends StatefulWidget {
  final String blogId;
  ApiSinglePage({ Key key, this.blogId }): super(key: key);
  @override
  _ApiSinglePageState createState() => _ApiSinglePageState();


}

class _ApiSinglePageState extends State<ApiSinglePage> {
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
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(FeatherIcons.xCircle, size: 30.0, color: Colors.blueGrey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,

        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: () {

              },
              child: Icon(FeatherIcons.share2)
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              Text('New york won\'t return to normal life soon, though it has reduced 42% of it\'s air pollution',style: TextStyle(fontFamily: 'Josefin Sans',color: Colors.black,fontSize: 30,),),
              SizedBox(height: 10,),
              Image.asset('assets/cars.jpg'),
              SizedBox(height: 20,),
              Text('New york won\'t return to normal life soon, though it has reduced 42% of it\'s air pollution,New york won\'t return to normal life soon, though it has reduced 42% of it\'s air pollution',style: TextStyle(fontFamily: 'Product Sans',color: Colors.black,fontSize: 18,),),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Card(
          elevation: 1,
          shadowColor: Colors.grey,
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Icon(FeatherIcons.thumbsUp),
                SizedBox(width: 20,),
                Icon(FeatherIcons.thumbsDown),
                Expanded(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(icon: Icon(FeatherIcons.messageSquare,color: Colors.black,), onPressed: null,),
                      ],
                    ))
              ],
            ),
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}
