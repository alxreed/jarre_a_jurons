import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:jarreajurons/my_friend_page.dart';
import 'package:jarreajurons/my_profile.dart';
import 'package:jarreajurons/service/auth_service.dart';

class RoutingPage extends StatefulWidget {
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
        stream: authService.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PageView(
              controller: _controller,
              children: [MyProfile(), MyFriendPage()],
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.purple[700],
              body: Center(
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    authService.googleSignIn();
                  },
                  icon: Icon(
                    FontAwesome.google,
                    color: Colors.purple[700],
                  ),
                  label: Text(
                    'Sign in with Google',
                    style: TextStyle(color: Colors.purple[700]),
                  ),
                ),
              ),
            );
          }
        });
  }
}
