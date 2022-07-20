import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simsocial/Firebase_Back_in/database.dart';
import 'package:simsocial/objects/Post_blueprint.dart';
import 'package:simsocial/widgets/AppDrawer.dart';
import 'package:simsocial/widgets/PostView.dart';

import '../Firebase_Back_in/Authentication.dart';
import '../widgets/Loading.dart';

class Chat_page extends StatefulWidget {
  
  final String Thread_ID;

  State<Chat_page> createState() => Chat_pageState();
  
  Chat_page({
    required this.Thread_ID,
  });
}

class Chat_pageState extends State<Chat_page> {
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
          Text(widget.Thread_ID),Expanded(
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
                              ListTile(title:Text(widget.Thread_ID))
                              );
                }
                return Loading();
              },
            ),
          ),
        ])
        );
  }
}
