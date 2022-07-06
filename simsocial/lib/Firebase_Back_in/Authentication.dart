import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//Sign the user in, and return control back to the
//Authentication page
  Future<void> Sign_in(String email, String password, dynamic context) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    return;
  }

//Sign the user up then return control back to the
//Authentication page
  Future<void> Sign_up(String email, String password, dynamic context) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return;
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final userData = await FacebookAuth.instance.getUserData();

    print(userData);

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return _auth.signInWithCredential(facebookAuthCredential);
  }
}
