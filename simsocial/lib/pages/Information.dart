import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../widgets/Loading.dart';

class information extends StatefulWidget {
  information({Key? key}) : super(key: key);

  State<information> createState() => Information();
}

class Information extends State<information> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  bool loading = false;
  TextEditingController _first = TextEditingController();
  TextEditingController _last = TextEditingController();
  TextEditingController _bio = TextEditingController();
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
                          return "PassWord can not be empty";
                        }
                        if (value.length < 7) {
                          return "Password too Short ";
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
                    /**Submit Button */
                    OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            log_in();
                          }
                        },
                        child: Text("Submit")),
                  ],
                )));
  }

  Future<void> log_in() async {
    try {
      final data = {
        "first_name": _first,
        "last_name": _last,
        "user_role": "custumer",
        "bio": _bio,
      };
      db
          .collection("Users")
          .doc(_auth.currentUser?.uid)
          .collection("Personal Information")
          .doc("Profile Information")
          .set(data, SetOptions(merge: true))
          .onError((e, _) => setState(() {
                loading = false;
                this.info = e.toString();
              }));

      // var registerResponse = await _auth.currentUser.;

      //var user_name = _auth.currentUser!.displayName;

      setState(() {
        loading = false;

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("All Good  "),
        ));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
