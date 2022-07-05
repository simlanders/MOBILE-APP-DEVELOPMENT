import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Post_blueprint {
  //The name the user displays to other users
  final String display_name;

  //final String? timestamp;

  //The actual post message
  final String post;

  //Was this post shared from another user:
  //        If So set shared_from = to that user ID
  //       else
  //            shared_from = The current user ID
  final String shared_from;

  //The number of likes.toString()
  final String likes;

  //The number of dislikes.toString()
  final String dislikes;

  //The number of comment.toString()
  final String comments;

  // This is the  ID given to each post
  final String post_ID;

//constructor
  Post_blueprint({
    required this.post_ID,
    required this.display_name,
    required this.post,
    required this.shared_from,
    required this.likes,
    required this.dislikes,
    required this.comments,
  });

  factory Post_blueprint.fromMap(String id, Map<String, dynamic> data) {
    return Post_blueprint(
      post_ID: id,
      display_name: data['display_name'],
      post: data['post'],
      shared_from: data['shared_from'],
      likes: data['likes'],
      dislikes: data['dislikes'],
      comments: data['comments'],
    );
  }

  Map<String, dynamic> toJson() => {
        'post_ID': post_ID,
        'display_name': display_name,
        
        'post': post,
        'shared_from': shared_from,
        'likes': likes,
        'dislikes': dislikes,
        'comments': comments,
      };
}
