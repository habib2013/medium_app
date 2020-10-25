import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medium_app/NewsArticle.dart';
import 'package:medium_app/NewsHelper.dart';
import 'package:medium_app/data/data.dart';
import 'package:medium_app/models/models.dart';
import 'package:medium_app/Widget/stories.dart';
class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: ListView.builder(
          itemCount: NewsHelper.articleCount,
          itemBuilder: (context, position) {
            NewArticle article = NewsHelper.getArticle(position);
            if(position == 2){
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Trending headlines',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0,color: Colors.blueGrey,fontFamily: 'Josefin Sans'),),
                        Icon(Icons.arrow_forward,color: Colors.blueGrey,),
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    Stories(currentUser: currentUser,stories: stories),


                  ],
                ),
              );
            }
            return
              Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.5),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0,horizontal: 7.0),
                        child: Text(
                          article.categoryTitle,
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
                                child: Image.asset(
                                  "assets/" + article.imageAssetName,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                article.title,
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
                                    article.author,
                                    style: TextStyle(fontSize: 14.0,fontFamily: 'Josefin Sans'),
                                  ),
                                  SizedBox(width: 13,),
                                  Icon(FeatherIcons.calendar,color: Colors.blueGrey,),
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
        ));
  }
}