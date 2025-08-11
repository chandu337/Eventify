import 'package:flutter_eventify/student/student_status/model/student_status_model.dart';
import 'package:flutter_eventify/student/student_status/service/student_status_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'student_status_provider.g.dart';

@riverpod
Future<List<StudentStatusModel>> StudentStatusList(StudentStatusListRef ref){
  return StudentStatusService.fetchStatus();
}