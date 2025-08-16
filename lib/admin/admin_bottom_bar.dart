import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
class AdminBottomBar extends StatelessWidget {
  final Widget child;
  const AdminBottomBar({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    final String location= GoRouterState.of(context).uri.toString();
    int currentIndex = _calculatecurrentIndex(location);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index){
          switch(index){
            case 0:
            context.go('/admin/home');
            break;
            case 1:
            context.go('/admin/clubs');
            break;
            case 2:
            context.go('/admin/createEvent');
            break;
            case 3:
            context.go('/admin/profile');
            break;
          }
        },
        backgroundColor: const Color.fromARGB(255, 225, 148, 238),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blue, 
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.celebration),label: "Clubs"),
          BottomNavigationBarItem(icon: Icon(Icons.add),label: "Create event"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile")
        ],
      ),  
    );
  }
}
int _calculatecurrentIndex(String location){
  if(location.contains('/admin/home')) return 0;
  if(location.contains('/admin/clubs')) return 1;
  if(location.contains('/admin/createEvent')) return 2;
  if(location.contains('/admin/profile')) return 3;
  return 0; 
}