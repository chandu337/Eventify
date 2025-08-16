import 'package:flutter_eventify/admin/create_events/model/create_event_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class CreateEventService {
  static Future<List<CreateEventModel>> fetchEventItems() async{
    final supabase = Supabase.instance.client;
    final user_id = supabase.auth.currentUser!.id;
    
    final response = await supabase.from("events").select().eq("created_by", user_id);
    
    return (response as List).map((item)=>CreateEventModel.fromJson(item)).toList();
  }
  static Future<List<CreateEventModel>> fetchStudentEventItems() async{
    final supabase = Supabase.instance.client;
    final response = await supabase.from("events").select();
    
    return (response as List).map((item)=>CreateEventModel.fromJson(item)).toList();
  }
  static Future<void> deleteEventItem(String id) async {
    final supabase = Supabase.instance.client;
    await supabase.from("events").delete().eq("id", id);
    
  }
  static Future<void> updateEventItem(CreateEventModel event) async {
  final supabase = Supabase.instance.client;

  if (event.id == null) {
    throw Exception("Event ID is required for update");
  }
  try{
    await supabase
        .from("events")
        .update(event.toJson())
        .eq("id", event.id!).select();
  }
  
  catch(e) {
    throw Exception("Failed to update event: $e");
  }
}

}