import 'dart:collection';



class Coversation_blueprint {
  //The name the user displays to other users
  final String conversation_ID;

  final users= new HashMap();

 

//constructor
  Coversation_blueprint({
    required this.conversation_ID, 
    required users,
    
    
    
  });

  

   factory Coversation_blueprint.fromMap(String id, Map<String, dynamic> data) {
    return Coversation_blueprint(
        conversation_ID: id,
        users: data['users'],
      );
    } 

       Map<String, dynamic> toJson() => {
        'conversation_ID': conversation_ID,
        'users': users,
        
      };
  
 
}