import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";

class OverlayCard extends StatelessWidget {
  const OverlayCard({Key key, this.imageFile,this.title,this.body}) : super(key: key);
  final PickedFile imageFile;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.5),
          child:
          Card(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Tile View',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Josefin Sans',
                          fontSize: 23.0),
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 100.0,
                                width: 80.0,
                                child:   Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(File(imageFile.path)),
                                          fit: BoxFit.fitWidth)),
                                ),
                              ),
                            ),

                            Flexible(

                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,

                                    children: [
                                      Text(
                                        'Category',

                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Josefin Sans',
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Product Sans',
                                        fontSize: 17.0),
                                  ),
                                SizedBox(height: 15,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Username',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Josefin Sans',
                                            color: Colors.black,
                                            fontSize: 16.0),
                                      ),
                                      SizedBox(width: 20,
                                      ),
                                      Text(
                                        '5 mins read',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Josefin Sans',
                                            color: Colors.black45,
                                            fontSize: 14.0),
                                      ),
                                      SizedBox(width: 50,
                                      ),
                                      Icon(FeatherIcons.star,color: Colors.orange,size: 20,)
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
                SizedBox(height: 10,),
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
      
              ]
    );
  }


}
