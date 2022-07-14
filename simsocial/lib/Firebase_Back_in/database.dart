import 'package:uuid/uuid.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simsocial/objects/Post_blueprint.dart';
import 'package:simsocial/objects/User_blueprint.dart';

import '../objects/Comment_blueprint';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var uuid = Uuid();

  static Map<String, User_blueprint> userMap = <String, User_blueprint>{};

  final StreamController<Map<String, User_blueprint>> _usersController =
      StreamController<Map<String, User_blueprint>>();

  final StreamController<List<Post_blueprint>> _postsController =
      StreamController<List<Post_blueprint>>();

  final StreamController<List<Comment_blueprint>> _commentsController =
      StreamController<List<Comment_blueprint>>();

  DatabaseService() {
    _firestore.collection('users').snapshots().listen(_usersUpdated);
    _firestore.collection('posts').snapshots().listen(_postsUpdated);
    _firestore.collection('comments').snapshots().listen(_commentsUpdated);
  }

  Stream<Map<String, User_blueprint>> get users => _usersController.stream;

  Stream<List<Post_blueprint>> get posts => _postsController.stream;

  Stream<List<Comment_blueprint>> get comments => _commentsController.stream;

  void _usersUpdated(QuerySnapshot<Map<String, dynamic>> snapshot) {
    var users = _getUsersFromSnapshot(snapshot);
    _usersController.add(users);
  }

  void _postsUpdated(QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Post_blueprint> posts = _getPostsFromSnapshot(snapshot);
    _postsController.add(posts);
  }

  void _commentsUpdated(QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Comment_blueprint> comments = _getCommentsFromSnapshot(snapshot);
    _commentsController.add(comments);
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

  List<Comment_blueprint> _getCommentsFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Comment_blueprint> comments = [];

    for (var element in snapshot.docs) {
    

      Comment_blueprint comment =
          Comment_blueprint.fromMap(element.id, element.data());
      print(comment.display_name);
      comments.add(comment);
    }
    comments.sort((a, b) => a.created.compareTo(b.created));
    return comments;
  }

  Future<User_blueprint> getUser(String uid) async {
    var snapshot = await _firestore.collection("users").doc(uid).get();
    return User_blueprint.fromMap(snapshot.id, (snapshot.data()!));
  }

  Future<Post_blueprint> getPost(String uid) async {
    var snapshot = await _firestore.collection("posts").doc(uid).get();
    return Post_blueprint.fromMap(snapshot.id, (snapshot.data()!));
  }

  void addlikes(String uid, String likes) async {
    final data = {"likes": likes};

    _firestore.collection("posts").doc(uid).set(data, SetOptions(merge: true));
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
    try {
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
      }).whenComplete(() => print("===============>>" + "Complete"));
    } on Exception catch (e) {
      print(e.toString() + "<================");
    }

    return;
  }

  Future<void> addcomment(
    final String? display_name,

    //The actual post message
    final String comment,
    // This is the  ID given to each post

    final String post_ID,
    final String creator,
  ) async {
    try {
      String now = DateTime.now().toString();
      await _firestore.collection('comments').add({
        'display_name': display_name,
        'post_ID': post_ID,
        'comment': comment,
        'creator': creator,
        'created': now,
      }).whenComplete(() => print("===============>>" + "Complete"));
    } on Exception catch (e) {
      print(e.toString() + "<================");
    }

    return;
  }
}
