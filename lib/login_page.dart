import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:jarreajurons/routing_page.dart';
import 'package:jarreajurons/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: authService.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RoutingPage(user: snapshot.data);
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
