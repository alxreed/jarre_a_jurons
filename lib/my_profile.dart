import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarreajurons/invitations.dart';
import 'package:jarreajurons/model/user.dart';
import 'package:jarreajurons/search_users.dart';
import 'package:jarreajurons/services/auth_service.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key key, this.title, this.user}) : super(key: key);

  final String title;
  final User user;

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  int _moneyEarnedBy;
  int index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('users')
          .document(widget.user.friends[index].uid)
          .snapshots(),
      builder: (context, snapshot) {
        _moneyEarnedBy = getMoneyEarnedBy(snapshot);
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
                if (widget.user.friends.length > 0)
                  Container(
                    child: Column(
                      children: <Widget>[
                        if (_moneyEarnedBy != 0) ...[
                          Center(
                            child: Text(
                              'Vous devez',
                              style: TextStyle(
                                  color: Colors.yellow[800],
                                  fontFamily: 'Bratsy',
                                  fontSize: 70,
                                  height: 1),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Text(
                              '$_moneyEarnedBy €',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Bratsy',
                                  fontSize: 120,
                                  height: 1),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                        if (_moneyEarnedBy == 0)
                          Center(
                            child: Text(
                              'Vous ne devez rien',
                              style: TextStyle(
                                  color: Colors.yellow[800],
                                  fontFamily: 'Bratsy',
                                  fontSize: 70,
                                  height: 1),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        Center(
                          child: Text(
                            'à ${widget.user.friends[index].name}',
                            style: TextStyle(
                                color: Colors.yellow[800],
                                fontFamily: 'Bratsy',
                                fontSize: 70,
                                height: _moneyEarnedBy != 0 ? 0.5 : 1.2),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (widget.user.friends.length == 0)
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
/*                FloatingActionButton.extended(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    print("rends l'argent");
                    _showDialog();
                  },
                  label: Text(
                    'PAYER',
                    style: TextStyle(color: Colors.purple[700]),
                  ),
                ),*/
                if (widget.user.friends.length > 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (index > 0)
                        FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              index--;
                            });
                          },
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.purple[700],
                            size: 30,
                          ),
                        ),
                      if (index > 0)
                        SizedBox(
                          width: 20,
                        ),
                      if (index < widget.user.friends.length - 1)
                        FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              index++;
                            });
                          },
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.purple[700],
                            size: 30,
                          ),
                        ),
                    ],
                  )
              ],
            ));
      },
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Aucun moyen de paiement connecté'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK BB'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  int getMoneyEarnedBy(AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      int moneyEarned = 0;
      snapshot.data["friends"].forEach((friend) {
        if (friend["uid"] == widget.user.uid) {
          moneyEarned = friend["moneyEarned"];
        }
      });
      return moneyEarned;
    } else {
      return 0;
    }
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
