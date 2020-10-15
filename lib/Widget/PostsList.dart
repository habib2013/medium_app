import 'package:flutter/material.dart';
import 'package:medium_app/Widget/stories.dart';
import 'package:shimmer/shimmer.dart';
import 'package:medium_app/data/data.dart';
import 'package:medium_app/models/models.dart';

class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Trending Topics',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0,color: Colors.blueGrey,fontFamily: 'Raleway'),),
                  Icon(Icons.arrow_forward,color: Colors.blueGrey,),
                ],
              ),
              SizedBox(height: 20.0,),
              Expanded(

                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  enabled: _enabled,
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
                    itemCount: 4,
                  ),
                ),
              ),
              SizedBox(height: 10.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('All Time Best',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0,color: Colors.blueGrey,fontFamily: 'Raleway'),),
                  Icon(Icons.arrow_forward,color: Colors.blueGrey,),
                ],
              ),
              SizedBox(height: 20.0,),
              Stories(currentUser: currentUser,stories: stories),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _enabled = !_enabled;
                      });
                    },

                ),
              )
            ],
          ),

          ),
      ),
    );
  }


  Widget _PostListsView(){
    return ListView.builder(
        itemCount: 0,
        itemBuilder: (BuildContext context,int index)  {
          return ListTile(
            title: Text('This is the title'),
            subtitle: Column(
              children: [
                Text('This is a Test'),
                Icon(Icons.add)
              ],
            ),

          );
        }

    );
  }
}
