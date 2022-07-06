
import 'package:flutter/material.dart';



class HomeFeed extends StatelessWidget {
  const HomeFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome you Fat Bitch'),
        ),
        body: const Center(
          child: Text('Hello to MY fatty Friend'),
        ),
      ),
    );
  }
}