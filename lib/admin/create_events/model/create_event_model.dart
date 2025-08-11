import 'package:json_annotation/json_annotation.dart';
part 'create_event_model.g.dart';
@JsonSerializable()
class CreateEventModel {
  final String? id;
  final String title;
  final String description;
  final String image;
  final String club;
  final String location;
  final DateTime date;
  final String created_by;

  CreateEventModel({this.id,required this.title, required this.description, required this.image, required this.club, required this.location, required this.date, required this.created_by});

  factory CreateEventModel.fromJson(Map<String,dynamic>json)=> _$CreateEventModelFromJson(json);
  Map<String,dynamic> toJson()=> _$CreateEventModelToJson(this);

}