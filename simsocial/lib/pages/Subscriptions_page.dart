import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simsocial/Firebase_Back_in/database.dart';
import 'package:simsocial/objects/Post_blueprint.dart';
import 'package:simsocial/pages/Chat_page.dart';
import 'package:simsocial/widgets/AppDrawer.dart';
import 'package:simsocial/widgets/PostView.dart';
import 'package:simsocial/widgets/SubscriptionView.dart';

import '../Firebase_Back_in/Authentication.dart';
import '../objects/Conversation_blueprint.dart';
import '../widgets/Loading.dart';
import 'NewChat_page.dart';

class Subscriptions_page extends StatefulWidget {
  Subscriptions_page({Key? key}) : super(key: key);

  State<Subscriptions_page> createState() => SubscriptionsState();
}

class SubscriptionsState extends State<Subscriptions_page> {
  final _authService = new AuthenticationService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService db = new DatabaseService();
  final TextEditingController post = TextEditingController();
  late String user_name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewChat_page()));
              },
            ),
          ],
          title: const Text('Subscriptions'),
        ),
        body: Column(children: [
          Text('Messages'),
          Expanded(
            child: StreamBuilder<List<Conversation_blueprint>>(
              stream: db.conversations,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Conversation_blueprint>> snapshot) {
                //print("here NCP L48");
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("An error has occured!"),
                  );
                } else if (snapshot.hasData) {
                  //print("subscription_page L53 snapshot has data");
                  var conversations = snapshot.data ?? [];
                  return conversations.isEmpty
                      ? const Center(child: Text("Click + to start Chat"))
                      : ListView.builder(
                          itemCount: conversations.length,
                          itemBuilder: (BuildContext context, int index) {
                            var rawUsers = conversations[index].users;
                            var user_name = getUser(rawUsers);
                            return new SubscriptionView(
                                conversation_ID:
                                    conversations[index].conversation_ID,
                                thread_ID: conversations[index].thread_ID,
                                user: user_name);
                          });
                }
                return Loading();
              },
            ),
          ),
        ]));
  }

  String getUser(var users)  {
    for (var u in users) {
      var user_id_without_brackets =
          u.replaceAll(new RegExp(r"\p{P}", unicode: true), "");
      if (user_id_without_brackets != _auth.currentUser!.uid) {
        return user_id_without_brackets.toString();
      }
    }
    return "";
  }

  
}
