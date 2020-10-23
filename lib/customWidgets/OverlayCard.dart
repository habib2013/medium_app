import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OverlayCard extends StatelessWidget {
  const OverlayCard({Key key, this.imageFile,this.title}) : super(key: key);
  final PickedFile imageFile;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(File(imageFile.path)),
                    fit: BoxFit.fitWidth)),
          ),
          Positioned(
            bottom: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                height:55,
                decoration: BoxDecoration(
                  color: Colors.transparent,borderRadius: BorderRadius.zero
                ),
                width: MediaQuery.of(context).size.width,
                child: Text(title,style: TextStyle(fontFamily: 'Raleway',color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
              )
          )
        ],
      ),
    );
  }
}
