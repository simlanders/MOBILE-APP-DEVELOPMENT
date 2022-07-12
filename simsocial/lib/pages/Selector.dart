import 'package:flutter/material.dart';
import 'package:simsocial/pages/SignInSelector.dart';

import 'SignUpSelector.dart';

class Selector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Sends you to the SignInSelector() page to sign in with email or facebook
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignInSelector()));
                },
                child: Text("SIGN IN"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: BorderSide(color: Colors.red)),
                  ),
                )),
            //Adds space between the boxes
            SizedBox(
              height: 25,
            ),
            //Sends you to the SignUpSelector() page to sign up with email or facebook
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpSelector()));
                },
                child: Text("SIGN UP"),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red))))),
          ],
        ),
      ),
    );
  }
}
