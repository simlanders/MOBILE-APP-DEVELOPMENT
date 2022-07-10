import 'dart:async';
import 'package:flutter/material.dart';
import 'package:simsocial/pages/Selector.dart';

class SplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<SplashScreen> {
  //initializes A Timer to hold The widget onscreen, 
  //then It sends the user to the  
  //Selector() to Choose Log in or sign up. 
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Selector())));
  }
  //Displays "Sim Social" In the moddle of the screen. 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Sim Social",
          style: TextStyle(fontSize: 30, color: Colors.greenAccent),
        ),
      ),
    );
  }
}
