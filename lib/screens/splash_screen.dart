import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override 
  void initState () {
    super.initState();
    _checkLoginStatus();
  }
  void _checkLoginStatus() async{
    await Future.delayed(Duration(seconds: 3));
    context.go('/login');
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Image.asset('assets/eventifylogo.jpg',height: 300,width: 300,),
          ),
      ),
    );
  }
}