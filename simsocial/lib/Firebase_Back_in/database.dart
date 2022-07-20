import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simsocial/objects/Post_blueprint.dart';
import 'package:simsocial/objects/User_blueprint.dart';

import '../objects/Comment_blueprint.dart';
import '../objects/Conversation_blueprint.dart';
import '../objects/SMS_blueprint.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var uuid = Uuid();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static Map<String, User_blueprint> userMap = <String, User_blueprint>{};

  final StreamController<List<User_blueprint>> _usersController =
      StreamController<List<User_blueprint>>();

  final StreamController<List<Post_blueprint>> _postsController =
      StreamController<List<Post_blueprint>>();

  final StreamController<List<SMS_blueprint>> _messagesController =
      StreamController<List<SMS_blueprint>>();

  final StreamController<List<Comment_blueprint>> _commentsController =
      StreamController<List<Comment_blueprint>>();

  final StreamController<List<Conversation_blueprint>> _conversationController =
      StreamController<List<Conversation_blueprint>>();

  DatabaseService() {
    _firestore.collection('users').snapshots().listen(_usersUpdated);
    _firestore.collection('posts').snapshots().listen(_postsUpdated);
    _firestore.collection('comments').snapshots().listen(_commentsUpdated);
    _firestore
        .collection('conversations')
        //.where('users', arrayContains: [_auth.currentUser!.uid])
        .snapshots()
        .listen(_conversationsUpdated);
  }
  DatabaseService.getMessages(String Thread_ID) {
    _firestore
        .collection('messages')
        .where('to', isEqualTo: Thread_ID)
        .snapshots()
        .listen(_messagesUpdated);
  }

  Stream<List<User_blueprint>> get users => _usersController.stream;

  Stream<List<Post_blueprint>> get posts => _postsController.stream;

  Stream<List<Comment_blueprint>> get comments => _commentsController.stream;

  Stream<List<Conversation_blueprint>> get conversations =>
      _conversationController.stream;

  Stream<List<SMS_blueprint>> get messages => _messagesController.stream;

  void _usersUpdated(QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<User_blueprint> users = _getUsersFromSnapshot(snapshot);
    _usersController.add(users);
  }

  void _postsUpdated(QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Post_blueprint> posts = _getPostsFromSnapshot(snapshot);
    _postsController.add(posts);
  }

  void _conversationsUpdated(QuerySnapshot<Map<String, dynamic>> snapshot) {
    //print("line 77 db convo updated " + snapshot.size.toString());
    List<Conversation_blueprint> conversations =
        _getConversationsFromSnapshot(snapshot);
    _conversationController.add(conversations);
  }

  void _messagesUpdated(QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<SMS_blueprint> messages = _getMessagesFromSnapshot(snapshot);
    _messagesController.add(messages);
  }

  void _commentsUpdated(QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Comment_blueprint> comments = _getCommentsFromSnapshot(snapshot);
    _commentsController.add(comments);
  }

  List<User_blueprint> _getUsersFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<User_blueprint> users = [];

    for (var element in snapshot.docs) {
      User_blueprint user = User_blueprint.fromMap(element.id, element.data());
      users.add(user);
    }

    return users;
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

  List<SMS_blueprint> _getMessagesFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<SMS_blueprint> messages = [];

    for (var element in snapshot.docs) {
      SMS_blueprint post = SMS_blueprint.fromMap(element.id, element.data());

      messages.add(post);
    }
    messages.sort((a, b) => a.time.compareTo(b.time));
    return messages;
  }

  List<Conversation_blueprint> _getConversationsFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Conversation_blueprint> conversations = [];
    //print("here db get convo from snapshot L134 " + snapshot.size.toString());
    for (var element in snapshot.docs) {
      //print("Inside for loop");
      Conversation_blueprint conversation =
          Conversation_blueprint.fromMap(element.id, element.data());
          final List<String> split_users = element.data()['users'].split(' ');
      for (var e in split_users) {
        conversation.users.add(e);
      }
      //print(conversation.toString());
      conversations.add(conversation);
    }

    return conversations;
  }

  List<Comment_blueprint> _getCommentsFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Comment_blueprint> comments = [];
    for (var element in snapshot.docs) {
      Comment_blueprint comment =
          Comment_blueprint.fromMap(element.id, element.data());

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

  Future<void> addNewMessage(
    Set<String> users,
    String user_id,
    String message,
  ) async {
    print("db L255 addNewconvo===>Users: " + users.toString());
    String now = DateTime.now().toString();
    var rng = new Random();
    var code = (rng.nextInt(900000) + 100000).toString();
    try {
      print("conversations");
      await _firestore
          .collection('conversations')
          .add({
            'users': users.toString(),
            'thread_ID': code
            }).whenComplete(
              () => addNewMessage2(
                    code,
                    message,
                    now,
                    user_id,
                  ));
    } on Exception catch (e) {
      print(e.toString() + "<================");
    }

    return;
  }

  Future<void> addNewMessage2(
      String code, String message, String now, String user_id) async {
    print("db L282 addNewMessage===>Code: " + code);

    try {
      print("messages");

      await _firestore.collection('messages').add({
        'to': code,
        'from': user_id,
        'message': message,
        'time': now,
      }).whenComplete(() => print("===============>>" + "Complete message"));
    } on Exception catch (e) {
      print(e.toString() + "<================");
    }

    return;
  }
}
