import 'package:flutter/material.dart';

import '../Firebase_Back_in/Authentication.dart';
import '../Firebase_Back_in/database.dart';
import 'Homefeed_page.dart';
import 'ProfileCreation_page.dart';
import 'UserCreation.dart';

class SignUpSelector extends StatelessWidget {
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
                onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserCreation()));
                  
                },
                child: Text("SIGN UP WITH EMAIL"),
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
                child: Text("SIGN UP WITH FACEBOOK"),
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
