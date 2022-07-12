import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simsocial/pages/Homefeed_page.dart';
import 'package:simsocial/pages/Profile.dart';

import '../pages/DM.dart';

class AppDrawer extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Navigation'),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('PROFILE'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile(user_id: _auth.currentUser!.uid)));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.newspaper_outlined,
            ),
            title: const Text('FEED'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeFeed()));
            
            },
          ),
          ListTile(
            leading: Icon(
              Icons.message,
            ),
            title: const Text('DM'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> DM()));
            },
          ),
        ],
      ),
    );
  }
}
