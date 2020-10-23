// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blogModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogModel _$BlogModelFromJson(Map<String, dynamic> json) {
  return BlogModel(
    coverImage: json['coverImage'] as String,
    count: json['count'] as int,
    share: json['share'] as int,
    comment: json['comment'] as int,
    id: json['id'] as String,
    username: json['username'] as String,
    title: json['title'] as String,
    body: json['body'] as String,
  );
}

Map<String, dynamic> _$BlogModelToJson(BlogModel instance) => <String, dynamic>{
      'coverImage': instance.coverImage,
      'count': instance.count,
      'share': instance.share,
      'comment': instance.comment,
      'id': instance.id,
      'username': instance.username,
      'title': instance.title,
      'body': instance.body,
    };
