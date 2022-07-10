import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:simsocial/Firebase_Back_in/database.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<String> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final userData = await FacebookAuth.instance.getUserData();

    print(userData);

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    _auth.signInWithCredential(facebookAuthCredential);
    

    return _auth.currentUser!.uid;
  }
}
