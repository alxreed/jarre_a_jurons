import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarreajurons/search_users.dart';
import 'package:jarreajurons/services/auth_service.dart';

import 'invitations.dart';
import 'model/user.dart';

class NoFriendProfile extends StatefulWidget {
  NoFriendProfile({Key key, this.title, this.user}) : super(key: key);

  final String title;
  final User user;

  @override
  _NoFriendProfileState createState() => _NoFriendProfileState();
}

class _NoFriendProfileState extends State<NoFriendProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple[700],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  child: FittedBox(
                    child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SearchUsers(user: widget.user)));
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 60,
                        )),
                  ),
                ),
                if (!widget.user.hasInvitations())
                  Container(
                    height: 50,
                    width: 50,
                    child: FittedBox(
                      child: FlatButton(
                          onPressed: _noInvite,
                          child: Icon(
                            Icons.drafts,
                            color: Colors.white,
                            size: 60,
                          )),
                    ),
                  ),
                if (widget.user.hasInvitations())
                  Container(
                    height: 50,
                    width: 50,
                    child: FittedBox(
                      child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Invitations(user: widget.user)));
                          },
                          child: Icon(
                            Icons.email,
                            color: Colors.white,
                            size: 60,
                          )),
                    ),
                  ),
                Container(
                  height: 50,
                  width: 50,
                  child: FittedBox(
                      child: FlatButton(
                    onPressed: () => authService.signOut(),
                    child: Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                      size: 60,
                    ),
                  )),
                ),
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(widget.user.photoUrl),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.user.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Bratsy',
                          fontSize: 40,
                          height: 1.3),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 120,),
                  Center(
                    child: Text(
                      "Vous n'avez pas d'ami",
                      style: TextStyle(
                          color: Colors.yellow[800],
                          fontFamily: 'Bratsy',
                          fontSize: 70,
                          height: 1),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 120,),
                ],
              ),
            ),
          ],
        ));
  }

  void _noInvite() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Vous n'avez pas de demande d'ajout"),
            actions: <Widget>[
              FlatButton(
                child: Text('GOT IT'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
