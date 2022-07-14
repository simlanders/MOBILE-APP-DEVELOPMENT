import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:simsocial/widgets/AppDrawer.dart';
import 'package:simsocial/widgets/ProfileView.dart';

import 'package:simsocial/objects/Comment_blueprint';

import '../Firebase_Back_in/database.dart';
import '../widgets/Loading.dart';
import '../widgets/PostView.dart';
import 'Profile.dart';

class CommentPage extends StatelessWidget {
  final DatabaseService db = new DatabaseService();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isVisable = false;
  final TextEditingController comment = TextEditingController();

  final String user_name;
  final String post;
  final String time;
  final String num_comments;
  final String num_likes;
  final String user_id;
  final String post_id;

  CommentPage({
    required this.user_name,
    required this.post,
    required this.time,
    required this.num_comments,
    required this.num_likes,
    required this.user_id,
    required this.post_id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(post_id),
          titleSpacing: 150,
        ),
        drawer: AppDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              TextFormField(
              controller: comment,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Reply to post',
              ),
            ),
          
          TextButton(
            onPressed: (() {
              db
                  .addcomment(_auth.currentUser!.displayName, comment.text, post_id,
                  _auth.currentUser!.uid)
                  .then((value) => comment.clear())
                  .whenComplete(() => print(db.posts.length.toString()));
            }),
            child: Text('comment'),
          ),
          
            //Post View
            Container(
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
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
                          child: Text(
                            user_name,
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
                          onPressed: () {
                            addlikes();
                          },
                        ),
                        const SizedBox(width: 170),
                        Text('Comments ' + num_comments),
                        const SizedBox(width: 0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //Comment view
            Text('Comments'),

            Expanded(
              child: StreamBuilder<List<Comment_blueprint>>(
                stream: db.comments,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Comment_blueprint>> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("An error has occured!"),
                    );
                  } else if (snapshot.hasData) {
                    var comments = snapshot.data ?? [];
                    List my_comments = [];
                    for (var element in comments) {
                      if (element.post_ID == post_id) {
                        print("===>");
                        my_comments.add(element);
                      }
                    }
                    return my_comments.isEmpty
                        ? const Center(child: Text("NO Post"))
                        : ListView.builder(
                            itemCount: my_comments.length,
                            itemBuilder: (BuildContext context, int index) =>
                                ListTile(
                              title: Text(my_comments[index].display_name),
                              subtitle: SizedBox(child: ListTile( 
                                title: Text(my_comments[index].comment),
                                ),
                                ),
                            ),
                          );
                  }
                  return Loading();
                },
              ),
            ),
          ],
        ));
  }

  Future<Future> getUser(context) async {
    var user = await db.getUser(user_id);
    print(user.display_name);

    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profile(
                  user_id: user_id,
                )));
  }

  Future<Future> getPost(context) async {
    var post = await db.getPost(post_id);
    var likes = int.parse(post.likes);
    print("===>");
    print(likes);
    print(likes + 1);

    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profile(
                  user_id: user_id,
                )));
  }

  void addlikes() async {
    var post = await db.getPost(post_id);
    var likes = int.parse(post.likes);
    print("old likes" + post.likes);
    likes = likes + 1;
    var slikes = likes.toString();
    print("new likes" + slikes);
    db.addlikes(post_id, slikes);
  }
}
