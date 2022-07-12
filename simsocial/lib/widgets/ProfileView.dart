import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:simsocial/pages/ProfileCreation_page.dart';

import 'AppDrawer.dart';

class ProfileView extends StatelessWidget {
  final String display_name;
  final String first;
  final String last;
  final String bio;
  final bool isVisable;

  ProfileView({
    required this.display_name,
    required this.bio,
    required this.first,
    required this.last,
    required this.isVisable
  });
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          titleSpacing: 150,
        ),
        drawer: AppDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (() => {print('------>')}),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                // set random = true
                // default is false
                child: ProfilePicture(
                  name: 'simeon',
                  radius: 60,
                  fontsize: 40,
                  random: true,
                ),
              ),
            ),
            Text(
              display_name,
              style: TextStyle(fontSize: 40, color: Colors.amber),
            ),
            Row(
              children: [
                SizedBox(
                  width: 50,
                ),
                Text(
                  first,
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                SizedBox(
                  width: 150,
                ),
                Text(
                  last,
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ],
            ),
            Text(
              bio,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Text(
              " Just getting things set up",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            Visibility(
                visible: isVisable,
                child: ListTile(
                  leading: Icon(Icons.edit, size: 50, color: Colors.redAccent),
                  title: const Text(
                    'Edit',
                    style: TextStyle(fontSize: 25, color: Colors.cyan),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileCreationPage()));
                  },
                ))
          ],
        ));
  }
}
