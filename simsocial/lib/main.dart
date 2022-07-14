import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simsocial/pages/SplashScreen.dart';
import 'package:simsocial/widgets/Loading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(simsocial());
}

class simsocial extends StatelessWidget {
  simsocial({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initFirebase = Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBl4y2j0n4qJaKBnD0wE0fybcQo6btgWBE",
        authDomain: "sim-social.firebaseapp.com",
        projectId: "sim-social",
        storageBucket: "sim-social.appspot.com",
        messagingSenderId: "900675515630",
        appId: "1:900675515630:web:408d6715f62c79b930afff",
        measurementId: "G-DFG1N465NS"),
  );
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        body: FutureBuilder(
          initialData: _initFirebase,
          future: _initFirebase,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              if (snapshot.error.toString() ==
                  '[core/duplicate-app] A Firebase App named "[DEFAULT]" already exists') {
                final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                return SplashScreen();
              }
              return Center(
                child: Text(
                    "Ooops an Error has Happened " + snapshot.error.toString()),
              );
            }
            if (snapshot.connectionState != ConnectionState.waiting) {
              final FirebaseFirestore _firestore = FirebaseFirestore.instance;
              return SplashScreen();
            }
            
            return SplashScreen();
          },
        ),
      ),
    );
  }
}
