import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../widgets/Loading.dart';
import '../Firebase_Back_in/database.dart';

class information extends StatefulWidget {
  information({Key? key}) : super(key: key);

  State<information> createState() => Information();
}

class Information extends State<information> {
  final dbService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  bool loading = false;
  TextEditingController _first = TextEditingController();
  TextEditingController _last = TextEditingController();
  TextEditingController _bio = TextEditingController();
  TextEditingController _display_name = TextEditingController();
  String info = "";

  @override
  Widget build(BuildContext context) {
    info = _auth.currentUser!.uid;
    return Scaffold(
        appBar: AppBar(
          title: const Text("EDIT PROFILE INFO"),
          // titleSpacing: 150,
        ),
        body: loading
            ? Loading()
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Plase edit your profile information here " + info,
                      style: TextStyle(fontSize: 30, color: Colors.blue),
                    ),

                    /**First name */
                    TextFormField(
                      controller: _first,
                      decoration: InputDecoration(
                          labelText: "First Name",
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.black)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email can not be empty";
                        }

                        return null;
                      },
                    ),

                    /**last name */
                    TextFormField(
                      controller: _last,
                      obscureText: false,
                      decoration: InputDecoration(
                          labelText: "Last Name",
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.black)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "name can not be empty";
                        }
                        if (value.length < 1) {
                          return "name too Short ";
                        }
                        return null;
                      },
                    ),

                    /**Bio name */
                    TextFormField(
                      controller: _bio,
                      obscureText: false,
                      decoration: InputDecoration(
                          labelText: "Bio",
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.black)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bio can not be empty";
                        }
                        if (value.length < 1) {
                          return "Bio too Short ";
                        }
                        return null;
                      },
                    ),

                    /**Display name */
                    TextFormField(
                      controller: _display_name,
                      obscureText: false,
                      decoration: InputDecoration(
                          labelText: "Display Name",
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.black)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Display name can not be empty";
                        }
                        if (value.length < 2) {
                          return "Display name too Short ";
                        }
                        return null;
                      },
                    ),

                    /**Submit Button */
                    OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            dbService.setUser(
                                _auth.currentUser!.uid,
                                _display_name.text,
                                _auth.currentUser!.email,
                                _first.text,
                                _last.text,
                                _bio.text);
                          }
                        },
                        child: Text("Submit")),
                  ],
                )));
  }

  Future<void> log_in() async {
    try {
      await dbService.setUser(_auth.currentUser!.uid, _display_name.text,
          _auth.currentUser!.email, _first.text, _last.text, _bio.text);
      setState(() {
        loading = false;

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("All Good  "),
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => information()));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
