import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simsocial/widgets/AppDrawer.dart';
import 'package:simsocial/widgets/PostView.dart';

import '../Firebase_Back_in/Authentication.dart';

class HomeFeed extends StatelessWidget {
  HomeFeed({super.key});
  final _authService = new AuthenticationService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String? userName = _auth.currentUser!.displayName;
    userName = _auth.currentUser!.displayName;
    if (_auth.currentUser!.displayName != null) {
      userName = _auth.currentUser!.displayName;
    } else {
      userName = 'edit name';
    }
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home Feed'),

        ),
        drawer: AppDrawer(),
        body: Column(
          children: <Widget>[
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tell The World How You Feel',
              ),
            ),
          ),
          TextButton(
            onPressed: (() {}),
            child: Text('Post'),
          ),
          Text('Post From Other Users'),
          Expanded( 
            child:
          ListView.builder(
              scrollDirection: Axis.vertical,
              //shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              itemCount: 100,
              itemBuilder: (context, i) {
                String? username = _auth.currentUser!.displayName;
                if (username == null) {
                  username = 'Edit Name';
                }
                return PostView();
              })
        ),]
      ),
      ),
    );
  }
}
