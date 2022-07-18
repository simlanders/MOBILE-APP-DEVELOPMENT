import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SMS_blueprint {

  final String message_ID;

 
  final String to;

  final String from;

 
  final String message;

  final String time;

//constructor
  SMS_blueprint(
      {
      required this.message_ID,
      required this.to,
      required this.from,
      required this.message,
      required this.time,
      });

  factory SMS_blueprint.fromMap(String id, Map<String, dynamic> data) {
    return SMS_blueprint(
      message_ID: id,
      to: data['to'],
      from: data['from'],
      message: data['message'],
      time: data['time'],
      
    );
  }

  Map<String, dynamic> toJson() => {
        'message_ID': message_ID,
        'to': to,
        'from': from,
        'message': message,
        'time': time,
        
      };
}
