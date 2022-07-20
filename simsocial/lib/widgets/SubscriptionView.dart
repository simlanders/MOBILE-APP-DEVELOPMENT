import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:simsocial/objects/User_blueprint.dart';
import 'package:simsocial/pages/Chat_page.dart';
import 'package:simsocial/pages/CommentPage.dart';
import 'package:simsocial/widgets/Loading.dart';
import 'package:simsocial/widgets/ProfileView.dart';

import '../Firebase_Back_in/database.dart';
import '../pages/Profile.dart';

class SubscriptionView extends StatefulWidget {
  final String conversation_ID;
  final String thread_ID;
  String user;

  SubscriptionView({
    required this.conversation_ID,
    required this.thread_ID,
    required this.user,
  });
  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  late DatabaseService db;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  initState() {
    super.initState();
    db = new DatabaseService();
    var users = db.users.first.then((value) {
      for (var v in value) {
        if (v.id == widget.user) {
          setState(() {
            widget.user = v.display_name;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.thread_ID);

    return Container(
      child: Card(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: (() => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Chat_page(
                                      Thread_ID: widget.thread_ID,
                                    )))
                      }),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ProfilePicture(
                        name: widget.thread_ID,
                        radius: 15,
                        fontsize: 10,
                        random: true,
                      ),
                      const SizedBox(width: 0),
                      Text(widget.user),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
