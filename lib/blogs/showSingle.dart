import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medium_app/NetworkHandler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:medium_app/models/TechNews.dart';
import 'package:http/http.dart' as http;
class ShowSingle extends StatefulWidget {
  final String blogId;

  ShowSingle({Key key, this.blogId}) : super(key: key);

  @override
  _ShowSingleState createState() => _ShowSingleState();
}

class _ShowSingleState extends State<ShowSingle> {
  NetworkHandler networkHandler = NetworkHandler();
  TechNews techie = TechNews();
  @override
  void initState() {
    // TODO: implement initState

    getBlogDetails();
    super.initState();
  }



  Widget showSingleBlogLists = Container(
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: ListView.builder(
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
//              Container(
//                width: 48.0,
//                height: 48.0,
//                color: Colors.white,
//              ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Container(
                          width: 40.0,
                          height: 8.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 370.0,
                height: 250.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
        itemCount: 1,
      ),
    ),
  );


  void getBlogDetails() async {
    String blogId = widget.blogId;
    var response = await networkHandler.get('blogPost/' + blogId);


    //     print(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> map = json.decode(response.body);
      Map<String, dynamic> myblogData = map["data"];
//      print(myblogData);
      String realcoverImage = myblogData['coverImage'];
      String cutUploadAway = realcoverImage.substring(8);
//      print('this is cutimage ${cutUploadAway}');
      setState(() {
        showSingleBlogLists = Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Text(
                  myblogData['title'],
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Image.network(
                  'http://192.168.137.1:5003/uploads/' +
                      cutUploadAway,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  myblogData['body'],
                  style: TextStyle(
                    fontFamily: 'Product Sans',
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(FeatherIcons.arrowLeftCircle,
              size: 30.0, color: Colors.blueGrey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          FlatButton(onPressed: () {}, child: Icon(FeatherIcons.share2)),
        ],
      ),
      body: showSingleBlogLists,
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
                SizedBox(
                  width: 20,
                ),
                Icon(FeatherIcons.thumbsDown),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        FeatherIcons.messageSquare,
                        color: Colors.black,
                      ),
                      onPressed: null,
                    ),
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
