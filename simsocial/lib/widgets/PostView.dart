import 'package:flutter/material.dart';

class PostView extends StatelessWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  child: const Text('UserName'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 0),
                Text('Posted'),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 500,
                height: 50,
                child: Text(
                    'Mescccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccsage'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  child: const Text('Share'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 175),
                Text('Time Posted'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  child: const Text('Likes 200'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 170),
                Text('Comments 4000'),
                const SizedBox(width: 0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buuild(String name) {
    return Container(
      child: Card(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  child: Text(name),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 0),
                Text('Posted'),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 500,
                height: 50,
                child: Text(
                    'Mescccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccsage'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  child: const Text('Share'),
                  onPressed: () {/* ... */},
                ),
                //const SizedBox(width: 75),
                Text('Time Posted'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  child: const Text('Likes 200'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 75),
                Text('Comments 4000'),
                const SizedBox(width: 0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
