import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jarreajurons/my_friend_page.dart';
import 'package:jarreajurons/my_profile.dart';

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
    return PageView(
      controller: _controller,
      children: [MyProfile(), MyFriendPage()],
    );
  }
}
