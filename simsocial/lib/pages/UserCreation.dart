import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'ProfileCreation_page.dart';

import '../widgets/Loading.dart';
import 'Homefeed_page.dart';
import '../Firebase_Back_in/Authentication.dart';

class UserCreation extends StatefulWidget {
  UserCreation({Key? key}) : super(key: key);

  State<UserCreation> createState() => UserCreationState();
}

class UserCreationState extends State<UserCreation> {
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
                      "Please enter your Email and Password to sign up ",
                      style: TextStyle(fontSize: 30, color: Colors.greenAccent),
                    ),
                    TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.black)
                              ),
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
                    TextFormField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
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
                    OutlinedButton(
                        onPressed: () {
                          _authService.Sign_up(
                                  _email.text, _password.text, context)
                              .whenComplete(() => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileCreationPage())));
                        },
                        child: Text("REGISTER")),
                    ],
                )));
  }
}
