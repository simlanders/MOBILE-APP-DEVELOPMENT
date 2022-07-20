import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simsocial/Firebase_Back_in/database.dart';
import 'package:simsocial/objects/Post_blueprint.dart';
import 'package:simsocial/widgets/AppDrawer.dart';
import 'package:simsocial/widgets/PostView.dart';

import '../Firebase_Back_in/Authentication.dart';
import '../objects/SMS_blueprint.dart';
import '../widgets/Loading.dart';

class Chat_page extends StatefulWidget {
  final String Thread_ID;

  State<Chat_page> createState() => Chat_pageState();

  Chat_page({
    required this.Thread_ID,
  });
}

class Chat_pageState extends State<Chat_page> {
  final _formKey = GlobalKey<FormState>();
  final _authService = new AuthenticationService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late DatabaseService db;
  final TextEditingController _message = TextEditingController();

  @override
  initState() {
    super.initState();
    db = new DatabaseService.getMessages(widget.Thread_ID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Group'),
        ),
        drawer: AppDrawer(),
        body: Form(
            key: _formKey,
            child: Column(children: [
              Text(widget.Thread_ID),
              Expanded(
                child: StreamBuilder<List<SMS_blueprint>>(
                  stream: db.messages,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<SMS_blueprint>> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("An error has occured!"),
                      );
                    } else if (snapshot.hasData) {
                      var messages = snapshot.data ?? [];
                      return messages.isEmpty
                          ? const Center(child: Text("NO Post"))
                          : ListView.builder(
                              itemCount: messages.length,
                              itemBuilder: (BuildContext context, int index) {
                                var color_tile;
                                if (messages[index].from ==
                                    _auth.currentUser!.uid) {
                                  color_tile = Colors.red;
                                } else {
                                  color_tile = Colors.blue;
                                }

                                return ListTile(
                                  title: Text(messages[index].message),
                                  tileColor: color_tile,
                                );
                              });
                    }
                    return Loading();
                  },
                ),
              ),
              
              TextFormField(
                controller: _message,
                decoration: InputDecoration(
                    labelText: "Type A Message",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Message can not be empty";
                  }

                  return null;
                },
              ),

              //Send button
              OutlinedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var users = <String>{};
                      String now = DateTime.now().toString();
                      

                      db.addNewMessage2(
                        widget.Thread_ID,
                        _message.text,
                        now,
                        _auth.currentUser!.uid,
                      );
                      _message.clear();
                    }
                  },
                  child: Text("SEND")),
            ])));
  }
}
