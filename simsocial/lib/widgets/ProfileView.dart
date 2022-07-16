import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:simsocial/pages/ProfileCreation_page.dart';

import '../Firebase_Back_in/database.dart';
import '../objects/Post_blueprint.dart';
import 'AppDrawer.dart';
import 'Loading.dart';
import 'PostView.dart';

class ProfileView extends StatelessWidget {
  final String display_name;
  final String first;
  final String last;
  final String bio;
  final bool isVisable;
  final String user_id;

  ProfileView(
      {required this.display_name,
      required this.bio,
      required this.first,
      required this.last,
      required this.isVisable,
      required this.user_id
      });
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService db = new DatabaseService();
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
              " Posts ",
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
                )),
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
                    List my_posts = [];
                    for (var element in posts) {
                      if (element.creator == user_id) {
                        print("===>");
                        my_posts.add(element);
                      }
                    }
                    return my_posts.isEmpty
                        ? const Center(child: Text("NO Post"))
                        : ListView.builder(
                            itemCount: my_posts.length,
                            itemBuilder: (BuildContext context, int index) =>
                                new PostView(
                                  user_name: my_posts[index].display_name,
                                  post: my_posts[index].post,
                                  time: my_posts[index].created,
                                  num_comments: my_posts[index].comments,
                                  num_likes: my_posts[index].likes,
                                  user_id: my_posts[index].creator,
                                  post_id: my_posts[index].post_ID,
                                ));
                  }
                  return Loading();
                },
              ),
            ),
          ],
        ));
  }
}
