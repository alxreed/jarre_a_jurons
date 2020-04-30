import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jarreajurons/my_friend_page.dart';
import 'package:jarreajurons/my_profile.dart';

import 'model/friend.dart';
import 'model/user.dart';

class RoutingPage extends StatefulWidget {
  final FirebaseUser user;

  RoutingPage({Key key, @required this.user}) : super(key: key);

  @override
  _RoutingPageState createState() => _RoutingPageState();
}

class _RoutingPageState extends State<RoutingPage> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('users').document(widget.user.uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('Loading...');
        DocumentSnapshot document = snapshot.data;
        User user = User(document);
        List<Friend> friends = user.friends;
        return PageView(
          controller: _controller,
          children: [
            MyProfile(user: user),
            ...new List.generate(friends.length, (index) => MyFriendPage(friend: friends[index])),
          ],
        );
      },
    );
  }
}
