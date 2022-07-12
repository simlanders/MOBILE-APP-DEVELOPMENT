import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simsocial/Firebase_Back_in/database.dart';
import 'package:simsocial/objects/Post_blueprint.dart';
import 'package:simsocial/widgets/AppDrawer.dart';
import 'package:simsocial/widgets/PostView.dart';

import '../Firebase_Back_in/Authentication.dart';
import '../widgets/Loading.dart';

class HomeFeed extends StatefulWidget {
  HomeFeed({Key? key}) : super(key: key);

  State<HomeFeed> createState() => HomeFeedState();
}

class HomeFeedState extends State<HomeFeed> {
  final _authService = new AuthenticationService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService db = new DatabaseService();
  final TextEditingController post = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Feed'),
        ),
        drawer: AppDrawer(),
        body: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: 
            TextFormField(
              controller: post,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tell The World How You Feel',
              ),
            ),
          ),
          TextButton(
            onPressed: (() {
              db
                  .addPost(_auth.currentUser!.displayName, post.text, 'none',
                      '0', '0', '0', _auth.currentUser!.uid)
                  .then((value) => post.clear())
                  .whenComplete(() => print(db.posts.length.toString()));
            }),
            child: Text('Post'),
          ),
          Text('Post From Other Users'),
          Expanded(
            child: StreamBuilder<List<Post_blueprint>>(
              stream: db.posts,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Post_blueprint>> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("An error has occured!"),
                  );
                } else if (snapshot.hasData) {
                  var posts = snapshot.data ?? [];
                  return posts.isEmpty
                      ? const Center(child: Text("NO Post"))
                      : ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (BuildContext context, int index) =>
                          
                              new PostView(
                                user_name:posts[index].display_name,
                                post: posts[index].post,
                                time:posts[index].created,
                                num_comments:posts[index].comments,
                                num_likes: posts[index].likes,
                                user_id: posts[index].creator,
                              ));
                }
                return Loading();
              },
            ),
          ),
        ]));
  }
}
