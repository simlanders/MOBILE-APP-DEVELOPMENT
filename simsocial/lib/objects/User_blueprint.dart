import 'package:cloud_firestore/cloud_firestore.dart';

class User_blueprint {
  //The first name of user
  final String first_name;

  //The last name of user
  final String last_name;

  //The role of the user;
  final String user_role = "Custumer";

  //User created bio
  final String bio;

  //Display name of user
  final String display_name;

  //User ID
  final String id;

  //This is the current date and time when the user created the account
  final DateTime timestamp = DateTime.now();

//constructor
  User_blueprint({
    required this.display_name,
    required this.first_name,
    required this.last_name,
    required this.bio,
    required this.id,
  });

  factory User_blueprint.fromMap(String id, Map<String, dynamic> data) {
    return User_blueprint(
      display_name: data['display_name'],
      first_name: data['first_name'],
      last_name: data['last_name'],
      bio: data['bio'],
      id: data['id']
    );
  }

  Map<String, dynamic> toJson() => {
        "display_name": display_name,
        "first_name": first_name,
        "last_name": last_name,
        "user_role": user_role,
        "bio": bio,
        "created": DateTime.now()
      };
}
