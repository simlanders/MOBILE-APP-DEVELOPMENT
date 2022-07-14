import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:simsocial/objects/User_blueprint.dart';
import 'package:simsocial/pages/CommentPage.dart';
import 'package:simsocial/widgets/Loading.dart';
import 'package:simsocial/widgets/ProfileView.dart';

import '../Firebase_Back_in/database.dart';
import '../pages/Profile.dart';

class PostView extends StatefulWidget {
  final DatabaseService db = new DatabaseService();

  final String user_name;
  final String post;
  final String time;
  String num_comments;
  final String num_likes;
  final String user_id;
  final String post_id;
  PostView({
    required this.user_name,
    required this.post,
    required this.time,
    required this.num_comments,
    required this.num_likes,
    required this.user_id,
    required this.post_id,
  });
  @override
  State<PostView> createState() => _PostState();
}

class _PostState extends State<PostView> {
  final DatabaseService db = new DatabaseService();

  @override
     initState(){
    super.initState();
    var count = 0;
    
   
    
     db.comments.listen((value) {
        print("db.comments====>");
      for (var c in value) {
        print(c.post_ID);
        print(widget.post_id);
        if (c.post_ID == widget.post_id) {
          count = count + 1;
        }
        
      }
      setState(() {
          widget.num_comments = count.toString();
        });
    }).onError((error, stackTrace) => null);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.user_name);

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
                      name: widget.user_name,
                      radius: 15,
                      fontsize: 10,
                      random: true,
                    ),
                  ),
                ),
                TextButton(
                  child: Text(
                    widget.user_name,
                    style: TextStyle(fontSize: 25),
                  ),
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
                child: Text(widget.post),
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
                Text(widget.time),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  child: Text('Likes ' + widget.num_likes),
                  onPressed: () {
                    addlikes();
                  },
                ),
                const SizedBox(width: 170),
                TextButton(
                  child: (Text('Comments ' + widget.num_comments)),
                  onPressed: () {
                    gotToPost(context);
                  },
                ),
                const SizedBox(width: 0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Future> gotToPost(context) async {
    var user = await db.getUser(widget.user_id);
    print(user.display_name);

    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentPage(
                  num_comments: widget.num_comments,
                  num_likes: widget.num_likes,
                  post_id: widget.post_id,
                  post: widget.post,
                  time: widget.time,
                  user_id: widget.user_id,
                  user_name: widget.user_name,
                )));
  }

  Future<Future> getUser(context) async {
    var user = await db.getUser(widget.user_id);
    print(user.display_name);

    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profile(
                  user_id: widget.user_id,
                )));
  }

  Future<Future> getPost(context) async {
    var post = await db.getPost(widget.post_id);
    var likes = int.parse(post.likes);
    print("===>");
    print(likes);
    print(likes + 1);

    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profile(
                  user_id: widget.user_id,
                )));
  }

  void addlikes() async {
    var post = await db.getPost(widget.post_id);
    var likes = int.parse(post.likes);
    print("old likes" + post.likes);
    likes = likes + 1;
    var slikes = likes.toString();
    print("new likes" + slikes);
    db.addlikes(widget.post_id, slikes);
  }
}
