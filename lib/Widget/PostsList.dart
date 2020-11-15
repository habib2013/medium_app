import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medium_app/NewsArticle.dart';
import 'package:medium_app/NewsHelper.dart';
import 'package:medium_app/blogs/showSingle.dart';
import 'package:medium_app/data/data.dart';
import 'package:medium_app/models/models.dart';
import 'package:medium_app/Widget/stories.dart';
import 'package:shimmer/shimmer.dart';
import 'package:medium_app/NetworkHandler.dart';
import 'package:medium_app/models/blogModel.dart';

class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  NetworkHandler networkHandler = NetworkHandler();
  BlogModel blogModel = BlogModel();
  bool circular = true;
  bool showHeart = true;
  Widget showBlogLists = Container(
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: ListView.builder(
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48.0,
                height: 48.0,
                color: Colors.white,
              ),
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
                      width: 40.0,
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        itemCount: 2,
      ),
    ),
  );

  void fetchPostsList() async {
    var response = await networkHandler.get('blogPost/getOwnBlog');

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> myblogData = map["data"];

//      print(myblogData[0]["title"]);
      setState(() {
        showBlogLists = ListView.builder(
          itemCount: myblogData.length,
          itemBuilder: (context, position) {
            String realcoverImage = myblogData[position]["coverImage"];
            if (position == 0) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello 🌱',
                        style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: 22,
                            color: Colors.blueGrey),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            myblogData[position]["username"] + ",",
                            style: TextStyle(
                                fontFamily: 'Josefin Sans',
                                fontSize: 40,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
//                        Text('Your Daily Read',style: TextStyle(fontFamily: 'Product Sans',fontSize: 18,color: Colors.black),),
//
                    ],
                  ),
                ),
              );
            }

            print(realcoverImage);
            String cutUploadAway = realcoverImage.substring(8);
            print(cutUploadAway);
            if (position == 1) {
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trending tech headlines',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21.0,
                              color: Colors.blueGrey,
                              fontFamily: 'Josefin Sans'),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.blueGrey,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Stories(currentUser: currentUser, stories: stories),
                  ],
                ),
              );
            }

            return Column(
              children: [
                InkWell(
                  onTap: () {
                    String blogPostId = myblogData[position]["_id"];

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ShowSingle(blogId: blogPostId)));
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.5),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          height: 100.0,
                                          width: 80.0,
                                          child: Image.network(
                                            'http://192.168.137.1:5003/uploads/' +
                                                cutUploadAway,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Column(
                                          children: [
                                            Row(

                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Category',
                                                      style: TextStyle(
                                                          color: Colors.black45,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              'Josefin Sans',
                                                          fontSize: 14.0),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 170,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Icon(FeatherIcons.moreVertical)
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              myblogData[position]["title"] ??
                                                  'Nothing',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Product Sans',
                                                  fontSize: 17.0),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  myblogData[position]
                                                          ["username"] ??
                                                      'Nothing',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily:
                                                          'Josefin Sans',
                                                      color: Colors.black,
                                                      fontSize: 16.0),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  '5 mins read',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily:
                                                          'Josefin Sans',
                                                      color: Colors.black45,
                                                      fontSize: 14.0),
                                                ),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.orange,
                                                  size: 20,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        flex: 3,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//
//                          Row(
//                            children: [
//                              Icon(FeatherIcons.user,color: Colors.blueGrey,),
//                              Text(
//                                " Habib",
//                                style: TextStyle(fontSize: 14.0,fontFamily: 'Josefin Sans'),
//
//                              ),
//                              SizedBox(width: 20.0,),
//                              Icon(FeatherIcons.calendar,color: Colors.blueGrey,),
//                              Text(
//                                '',
//                                style: TextStyle(fontSize: 14.0),
//
//                              ),
//                            ],
//                          ),
//
//                        ],
//                      ),
//                      Icon(FeatherIcons.heart)
//                    ],
//                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      });
    }
  }

  void initState() {
    super.initState();
    fetchPostsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showBlogLists,
    );
  }
}
