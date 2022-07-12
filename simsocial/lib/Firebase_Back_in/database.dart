import 'package:uuid/uuid.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simsocial/objects/Post_blueprint.dart';
import 'package:simsocial/objects/User_blueprint.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var uuid = Uuid();

  static Map<String, User_blueprint> userMap = <String, User_blueprint>{};

  final StreamController<Map<String, User_blueprint>> _usersController =
      StreamController<Map<String, User_blueprint>>();

  final StreamController<List<Post_blueprint>> _postsController =
      StreamController<List<Post_blueprint>>();

  DatabaseService() {
    _firestore.collection('users').snapshots().listen(_usersUpdated);
    _firestore.collection('posts').snapshots().listen(_postsUpdated);
  }

  Stream<Map<String, User_blueprint>> get users => _usersController.stream;

  Stream<List<Post_blueprint>> get posts => _postsController.stream;

  void _usersUpdated(QuerySnapshot<Map<String, dynamic>> snapshot) {
    var users = _getUsersFromSnapshot(snapshot);
    _usersController.add(users);
  }

  void _postsUpdated(QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Post_blueprint> posts = _getPostsFromSnapshot(snapshot);
    _postsController.add(posts);
  }

  Map<String, User_blueprint> _getUsersFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    for (var element in snapshot.docs) {
      User_blueprint user = User_blueprint.fromMap(element.id, element.data());
      userMap[user.id] = user;
    }

    return userMap;
  }

  List<Post_blueprint> _getPostsFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Post_blueprint> posts = [];
    
    for (var element in snapshot.docs) {
      
      Post_blueprint post = Post_blueprint.fromMap(element.id, element.data());
      
      posts.add(post);
    }
    posts.sort((a, b) => a.created.compareTo(b.created));
    return posts;
  }

  Future<User_blueprint> getUser(String uid) async {
    var snapshot = await _firestore.collection("users").doc(uid).get();
    return User_blueprint.fromMap(snapshot.id, (snapshot.data()!));
  }

//This method adds a new user to the Firebase Collection 'users' then
//returns control back to the program who called it.
  Future<void> setUser(String uid, String display_name, String? email,
      String first_name, String last_name, String bio) async {
    await _firestore.collection("users").doc(uid).set({
      "display_name": display_name,
      "first_name": first_name,
      "last_name": last_name,
      "user_role": "customer",
      "bio": bio,
      "created": DateTime.now().toString(),
      "id": uid,
    });
    return;
  }

  Future<void> addPost(
    String? display_name,
    String post,
    String shared_from,
    String likes,
    String dislikes,
    String comments,
    String creator,
  ) async {
    
    try{
      String now = DateTime.now().toString();
    await _firestore.collection('posts').add({
      'display_name': display_name,
      'post': post,
      'shared_from': shared_from,
      'likes': likes,
      'dislikes': dislikes,
      'comments': comments,
      'creator': creator,
      'created': now,
    }).whenComplete(() => print("===============>>"+"Complete"));
    }on Exception catch (e) {
  print(e.toString()+"<================");
}
    
    return;
  }
}
