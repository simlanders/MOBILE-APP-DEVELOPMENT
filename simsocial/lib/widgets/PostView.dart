import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:simsocial/objects/User_blueprint.dart';
import 'package:simsocial/widgets/Loading.dart';
import 'package:simsocial/widgets/ProfileView.dart';

import '../Firebase_Back_in/database.dart';
import '../pages/Profile.dart';

class PostView extends StatelessWidget {
  final DatabaseService db = new DatabaseService();

  final String user_name;
  final String post;
  final String time;
  final String num_comments;
  final String num_likes;
  final String user_id;
  PostView({
    required this.user_name,
    required this.post,
    required this.time,
    required this.num_comments,
    required this.num_likes,
    required this.user_id,
  });
  @override
  Widget build(BuildContext context) {
    print(user_name);
    return Container(
      child: Card(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: (() => {print('------>')}),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    // set random = true
                    // default is false
                    child: ProfilePicture(
                      name: user_name,
                      radius: 15,
                      fontsize: 10,
                      random: true,
                    ),
                  ),
                ),
                TextButton(
                  child: Text(user_name),
                  onPressed: () {
                    getUser(context);
                    
                  },
                ),
                const SizedBox(width: 0),
                Text('Posted'),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 500,
                height: 50,
                child: Text(post),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  child: const Text('Share'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 130),
                Text(time),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  child: Text('Likes ' + num_likes),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 170),
                Text('Comments ' + num_comments),
                const SizedBox(width: 0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Future> getUser(context) async {
    var user = await db.getUser(user_id);
    print(user.display_name);
    
    return Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile(user_id: user_id,)));
    
  }
}
