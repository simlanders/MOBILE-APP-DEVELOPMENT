import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Comment_blueprint {
  //The name the user displays to other users
  final String display_name;
 

  //The actual post message
  final String comment;
  // This is the  ID given to each post
  final String comment_ID;
  final String post_ID;

  final String creator;
  final String created;

//constructor
  Comment_blueprint({
    required this.comment_ID,
    required this.post_ID,
    required this.display_name,
    required this.comment,
    required this.creator,
    required this.created,
  });

  

   factory Comment_blueprint.fromMap(String id, Map<String, dynamic> data) {
    return Comment_blueprint(
        comment_ID: id,
        post_ID: data['post_ID'],
        display_name: data['display_name'],
        comment: data['comment'],
        creator: data['creator'],
        created: data['created'],
      );
    } 

       Map<String, dynamic> toJson() => {
        'comment_ID': comment_ID,
        'display_name': display_name,
        'post_ID': post_ID,
        'comment': comment,
       
        'creator':creator,
        'created': created,
      };
  
 
}