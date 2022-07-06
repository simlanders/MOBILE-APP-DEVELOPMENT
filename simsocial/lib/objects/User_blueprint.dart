import 'package:cloud_firestore/cloud_firestore.dart';

class User_blueprint {
  //The first name of user
  final String first_name;

  //The last name of user
  final String last_name;

  //The role of the user;
  final String user_role;

  //User created bio
  final String bio;

  //Display name of user
  final String display_name;

  //This value holds the date the user signed in and created a Profile.
  final String created;

  //User ID
  final String id;

//constructor
  User_blueprint({
    required this.display_name,
    required this.first_name,
    required this.last_name,
    required this.bio,
    required this.created,
    required this.user_role,
    required this.id,
  });

  factory User_blueprint.fromMap(String id, Map<String, dynamic> data) {
    return User_blueprint(
      display_name: data['display_name'],
      first_name:   data['first_name'],
      last_name:    data['last_name'],
      bio:          data['bio'],
      user_role:    data['user_role'],
      created:      data['created'],
      id:           data['id']
    );
  }

  Map<String, dynamic> toJson() => {
        "display_name": display_name,
        "first_name": first_name,
        "last_name": last_name,
        "user_role": user_role,
        "bio": bio,
        "created": created,
        "id":id,
      };
}
