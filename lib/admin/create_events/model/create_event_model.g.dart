// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEventModel _$CreateEventModelFromJson(Map<String, dynamic> json) =>
    CreateEventModel(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      club: json['club'] as String,
      location: json['location'] as String,
      date: DateTime.parse(json['date'] as String),
      created_by: json['created_by'] as String,
    );

Map<String, dynamic> _$CreateEventModelToJson(CreateEventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'club': instance.club,
      'location': instance.location,
      'date': instance.date.toIso8601String(),
      'created_by': instance.created_by,
    };
