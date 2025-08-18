import 'package:flutter_eventify/admin/admin_bottom_bar.dart';
import 'package:flutter_eventify/admin/admin_event_screen.dart';
import 'package:flutter_eventify/admin/admin_home_screen.dart';
import 'package:flutter_eventify/admin/clubs/clubs.dart';
import 'package:flutter_eventify/admin/create_events/create_events_screen.dart';
import 'package:flutter_eventify/screens/login_screen.dart';
import 'package:flutter_eventify/screens/register_screen.dart';
import 'package:flutter_eventify/screens/splash_screen.dart';
import 'package:flutter_eventify/student/student_bottom_bar.dart';
import 'package:flutter_eventify/student/student_home_screen.dart';
import 'package:flutter_eventify/student/student_profile_screen.dart';
import 'package:flutter_eventify/student/student_status/student_events_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
Future<String?> getUserRole() async{
  final userId = Supabase.instance.client.auth.currentUser!.id;
  final response = await Supabase.instance.client.from("profile").select().eq("id", userId).single();
  return response["role"] as String?;
}
final eventrouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final role = getUserRole();
    if (state.uri.toString() == '/' && role == 'admin') {
      return '/admin/home';
    } else if (state.uri.toString() == '/' && role == 'student') {
      return '/student/home';
    }
    return null;
  },
  routes: [
    GoRoute(path: "/", builder: (context,state)=>SplashScreen()),
    GoRoute(path: "/login", builder: (context,state)=> LoginScreen()),
    GoRoute(path: "/register", builder:(context, state) => RegisterScreen(),),
    GoRoute(path: "/myEvents", builder: (context, state)=>AdminEventScreen()),
    ShellRoute(
      builder: (context, state, child) {
        return AdminBottomBar(child: child);
      },
      routes: [
        GoRoute(path: '/admin/home', builder: (context, state) =>AdminHomeScreen()),
        GoRoute(path: '/admin/createEvent', builder: (context, state) => CreateEventScreen()),
        GoRoute(path: '/admin/clubs', builder: (context,state)=>ClubsScreen()),
        GoRoute(path: '/admin/profile',builder: (context,state)=> StudentProfileScreen()),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) {
        return StudentBottomBar(child: child); 
      },
      routes: [
        GoRoute(path: '/student/home', builder: (context, state) => StudentHomeScreen()),
        GoRoute(path: '/student/profile', builder: (context, state) => StudentProfileScreen()),
        GoRoute(path: '/student/events', builder: (context,state)=> StudentEventsScreen()),
        GoRoute(path: '/student/clubs',builder: (context,state)=>ClubsScreen())
      ],
    ),
  ],
);