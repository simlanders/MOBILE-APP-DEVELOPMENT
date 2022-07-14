import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simsocial/widgets/AppDrawer.dart';
import 'package:simsocial/widgets/ProfileView.dart';

import '../Firebase_Back_in/database.dart';

class Profile extends StatelessWidget {
  final DatabaseService db = new DatabaseService();
  final String user_id;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isVisable = false;

  Profile({
    required this.user_id,
  });

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser!.uid == user_id) {
      isVisable = true;
    } 
    getUser(context,isVisable,user_id);

    return SizedBox();
  }

  Future<Future> getUser(context, isVisable,user_id) async {
    var user = await db.getUser(user_id);
    
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileView(
                  display_name: user.display_name,
                  first: user.first_name,
                  last: user.last_name,
                  bio: user.bio,
                  isVisable: isVisable ,
                  user_id:user_id
                )));
  }
}
