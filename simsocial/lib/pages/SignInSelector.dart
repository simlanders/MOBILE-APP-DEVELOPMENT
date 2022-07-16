import 'package:flutter/material.dart';
import 'package:simsocial/pages/ProfileCreation_page.dart';
import 'package:simsocial/pages/FPassword.dart';

import '../Firebase_Back_in/database.dart';
import 'EmailAuthentication_page.dart';

import '../Firebase_Back_in/Authentication.dart';
import 'Homefeed_page.dart';

class SignInSelector extends StatelessWidget {
  final _authService = new AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmailAuthentication_page()));
                },
                child: Text("SIGN IN WITH EMAIL"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: BorderSide(color: Colors.red)),
                  ),
                )),
            SizedBox(
              height: 25,
            ),
            OutlinedButton(
                onPressed: () {
                  if (DatabaseService.userMap
                      .containsKey(_authService.signInWithFacebook())) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeFeed()));
                  }else{
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfileCreationPage()));
                  }
                },
                child: Text("SIGN IN WITH FACEBOOK"),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.red))))),
            OutlinedButton(
                onPressed: () {
                  
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FPassword()));
                  
                },
                child: Text("forgot password"),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.red))))),
          
            ],
        ),
      ),
    );
  }
}
