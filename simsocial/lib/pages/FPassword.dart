import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simsocial/pages/Selector.dart';
import 'ProfileCreation_page.dart';

import '../widgets/Loading.dart';
import 'Homefeed_page.dart';
import '../Firebase_Back_in/Authentication.dart';

class FPassword extends StatefulWidget {
  FPassword({Key? key}) : super(key: key);

  State<FPassword> createState() => FPasswordState();
}

class FPasswordState extends State<FPassword> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _authService = new AuthenticationService();

  bool loading = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Log In"),
          titleSpacing: 150,
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
                      "Please enter your Email ",
                      style: TextStyle(fontSize: 30, color: Colors.greenAccent),
                    ),
                    TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.black)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email can not be empty";
                        }
                        if (!value.contains('@')) {
                          return "Email In The Wrong Format";
                        }
                        return null;
                      },
                    ),
                    OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _email.clear();
                            _auth.sendPasswordResetEmail(email: _email.text);
                            Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Selector()));
                          }
                        },
                        child: Text("Reset")),
                  ],
                )));
  }
}
