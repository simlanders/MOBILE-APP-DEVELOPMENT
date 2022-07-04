import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simsocial/pages/Information.dart';



import '../widgets/Loading.dart';



class Authentication extends StatefulWidget {
  Authentication({Key? key}) : super(key: key);

  State<Authentication> createState() => _AuthState();
}

class _AuthState extends State<Authentication> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
                          if (_formKey.currentState!.validate()) {
                            log_in();
                          }
                        },
                        child: Text("LOGIN")),
                    OutlinedButton(
                        onPressed: () {
                          //register();
                        },
                        child: Text("REGISTER")),
                    OutlinedButton(
                        onPressed: () {}, child: Text("FORGOT PASSWORD")),
                  ],
                )));
  }
   
  Future<void> log_in() async {
    
      try {
        var registerResponse = await _auth.signInWithEmailAndPassword(
            email: _email.text, password: _password.text);
      
        var user_id = _auth.currentUser!.uid;

        setState(() {
          loading = false;

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Welcome Back---->  "+ user_id),
          ));
           Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => information()),
  );

        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
        
      }
    }
  
}
