import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simsocial/pages/Authentication_page.dart';

import 'widgets/Loading.dart';
import 'Firebase_Back_in/Authentication.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(simsocial());
}

class simsocial extends StatelessWidget {
  simsocial({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initFirebase = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: FutureBuilder(
          initialData: _initFirebase,
          future: _initFirebase,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Ooops an Error has Happened "+snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            } 
            return Authentication_page();
          },
        ),
      ),
    );
  }
}
