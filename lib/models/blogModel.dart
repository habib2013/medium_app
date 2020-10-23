import 'package:json_annotation/json_annotation.dart';
part 'blogModel.g.dart';

@JsonSerializable()
class BlogModel {
  String coverImage;
  int count;
  int share;
  int comment;
  String id;
  String username;
  String title;
  String body;


  BlogModel({
    this.coverImage,
    this.count,
    this.share,
    this.comment,
    this.id,
    this.username,
    this.title,
    this.body,
  });


  factory BlogModel.fromJson(Map<String,dynamic> json) => _$BlogModelFromJson(json);
  Map<String,dynamic> toJson() => _$BlogModelToJson(this);
}

