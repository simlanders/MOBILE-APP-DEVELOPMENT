import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../widgets/AppDrawer.dart';
import 'ProfileCreation_page.dart';

import '../widgets/Loading.dart';
import 'Homefeed_page.dart';
import '../Firebase_Back_in/Authentication.dart';

class DM extends StatefulWidget {
  DM({Key? key}) : super(key: key);

  State<DM> createState() => _DM_State();
}

class _DM_State extends State<DM> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _authService = new AuthenticationService();

  bool loading = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('DM'),
        ),
        drawer: AppDrawer(),
        body: Column(children: <Widget>[
          Text('Post From Other Users'),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  //shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: 100,
                  itemBuilder: (context, i) {
                    return SizedBox(
                      width: width,
                      child: Column(
                        children: [
                          Align(
                            child:Row(children: [Text('SentFrom')],),
                            alignment: Alignment.topLeft,
                            ),
                            Align(
                            child:Text('setfrom'),
                            
                            alignment: Alignment.topLeft,
                            ),
                            Align(
                            child:
                            Text('Time',
                            style: TextStyle(fontSize: 10, color: Colors.red),
                            ),
                            
                            alignment: Alignment.bottomRight,
                            )

                        ],
                      
                      )
                    );
                  }
                  )
                  ),
        ]),
      ),
    );
  }
}
