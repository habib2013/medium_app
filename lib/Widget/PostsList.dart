import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medium_app/NewsArticle.dart';
import 'package:medium_app/NewsHelper.dart';
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

  Widget showBlogLists = Container(
    child:Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: ListView.builder(
        itemBuilder: (_, __) =>
            Padding(
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
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0),
                        ),
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0),
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
            print(position);
            print(realcoverImage);
            String cutUploadAway = realcoverImage.substring(8);
            print(cutUploadAway);
          if (position == 2) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trending headlines',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
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
          return Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.5),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 7.0),
                      child: Text(
                        'categoryTitle',
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 80.0,
                              width: 80.0,
                              child: Image.network(
                              'https://hidden-dusk-12670.herokuapp.com/uploads/'+ cutUploadAway,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              myblogData[position]["title"] ?? 'Nothing',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Josefin Sans',
                                  fontSize: 15.0),
                            ),
                            flex: 3,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(FeatherIcons.user),
                                Text(
                                  myblogData[position]["username"] ?? 'Nothing',
                                  style: TextStyle(
                                      fontSize: 14.0, fontFamily: 'Josefin Sans'),
                                ),
                                SizedBox(
                                  width: 13,
                                ),
                                Icon(
                                  FeatherIcons.calendar,
                                  color: Colors.blueGrey,
                                ),
                                Text(
                                  '12-Oct-20',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(FeatherIcons.heart)
                      ],
                    )
                  ],
                ),
              ),
            ),
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
