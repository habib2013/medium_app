import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NetworkHandler{
//  String baseUrl = 'http://192.168.43.72:5003/';
//  String baseUrl = 'http://192.168.137.1:5003/';
  String baseUrl = 'https://hidden-dusk-12670.herokuapp.com/';

  final storage = new FlutterSecureStorage();

  var log = Logger();

  Future<http.Response> get(String url) async{
    String token  = await storage.read(key: "token");
    url = formatter(url);
    var response = await http.get(url,headers: {"Authorization": "Bearer $token"}
    );
    return response;
  }


  Future<http.Response> post(String url,Map<String,String> body) async{
    url =  formatter(url);
//    Map<String,dynamic> output = json.decode(response.body);
    String token  = await storage.read(key: "token");
    var response = await http.post(url,
        headers: {"Content-type": "application/json","Authorization": "Bearer $token"},
        body: json.encode(body) );
 return response;
  }

  Future<http.StreamedResponse> patchImage(String url,String filepath) async{
    url = formatter(url);
    String token  = await storage.read(key: "token");
    var request = http.MultipartRequest('PATCH',Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll(
       { "Content-type": "application/json",
        "Authorization": "Bearer $token"}
    );

    var response = request.send();
    return response;
  }
  
  String formatter(String url){
    return baseUrl + url;
  }

  NetworkImage getImage(String username){
    String url = formatter("uploads//$username.jpg");
    return NetworkImage(url);

  }
//  NetworkImage getBlogImage(String username){
//    String url = formatter("");
//    return NetworkImage(url);
//
//  }
}