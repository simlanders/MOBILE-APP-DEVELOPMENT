import 'dart:collection';

class Conversation_blueprint {
  //The name the user displays to other users
  final String conversation_ID;
  final String thread_ID;

  final Set<String> users;

//constructor
  Conversation_blueprint({
    required this.conversation_ID,
    required this.thread_ID,
    required this.users,
  });

  factory Conversation_blueprint.fromMap(String id, Map<String, dynamic> data) {
    return Conversation_blueprint(
      conversation_ID: id,
      users: {},
      thread_ID: data['thread_ID'],
    );
    
  }

  Map<String, dynamic> toJson() => {
        'conversation_ID': conversation_ID,
        'users': users,
        'thread_ID': thread_ID
      };
}
