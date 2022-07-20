import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simsocial/Firebase_Back_in/database.dart';
import 'package:simsocial/objects/Conversation_blueprint.dart';
import 'package:simsocial/objects/User_blueprint.dart';
import 'package:simsocial/widgets/AppDrawer.dart';

import 'ProfileCreation_page.dart';

import '../widgets/Loading.dart';
import 'Homefeed_page.dart';
import '../Firebase_Back_in/Authentication.dart';
import 'Subscriptions_page.dart';

class NewChat_page extends StatefulWidget {
  NewChat_page({Key? key}) : super(key: key);

  State<NewChat_page> createState() => _NewChat_PageState();
}

class _NewChat_PageState extends State<NewChat_page> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _authService = new AuthenticationService();
  final DatabaseService db = new DatabaseService();

  bool loading = false;
  TextEditingController _message = TextEditingController();
  final _to = <String>{}; // NEW
  final _biggerFont = TextStyle(fontSize: 18);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Start New Chat"),
          titleSpacing: 10,
        ),
        drawer: AppDrawer(),
        body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: StreamBuilder<List<User_blueprint>>(
                    stream: db.users,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<User_blueprint>> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("An error has occured fetching users!"),
                        );
                      } else if (snapshot.hasData) {
                        var users = snapshot.data ?? [];
                        //print("NCP L87 " + users.toString());
                        var count = 0;
                        return users.isEmpty
                            ? const Center(child: Text("NO USERS"))
                            : ListView.builder(
                                itemCount: users.length,
                                itemBuilder: (BuildContext context, int i) {
                                  //if (i.isOdd) return const Divider();

                                  //if(i<users.length) {
                                  // NEW
                                  final alreadySaved =
                                      _to.contains(users[i].id);
                                  return Column(
                                    children: [
                                    ListTile(
                                      title: Text( 
                                        users[i].display_name,
                                        style: _biggerFont,
                                        
                                      ),
                                      trailing: Icon(
                                        // NEW from here ...
                                        alreadySaved
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                        color: alreadySaved ? Colors.red : null,
                                        semanticLabel: alreadySaved
                                            ? 'Remove from saved'
                                            : 'Save',
                                      ),
                                      onTap: () {
                                        // NEW from here ...
                                        setState(() {
                                          if (alreadySaved) {
                                            _to.remove(users[i].id);
                                          } else {
                                            _to.add(users[i].id);
                                            print("NewChat_page====> _to: " +
                                                _to.toString());
                                          }
                                        });
                                      },
                                    ),
                                    const Divider()
                                  ]);
                                });
                      }
                      return Loading();
                    },
                  ),
                ),
                Text(
                  "Please enter your Message to begin Chat ",
                  style: TextStyle(fontSize: 30, color: Colors.greenAccent),
                ),
                TextFormField(
                  controller: _message,
                  decoration: InputDecoration(
                      labelText: "message",
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

                        for (var element in _to) {
                          users.add(element);
                        }
                        db
                            .addNewMessage(
                                users, _auth.currentUser!.uid, _message.text)
                            .whenComplete(() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Subscriptions_page())));
                      }
                    },
                    child: Text("SEND")),
              ],
            )));
  }
}
