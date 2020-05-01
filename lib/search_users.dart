import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarreajurons/controllers/friend_controller.dart';
import 'package:jarreajurons/controllers/user_controller.dart';
import 'package:jarreajurons/model/user.dart';
import 'package:jarreajurons/services/invitation_service.dart';

class SearchUsers extends StatefulWidget {
  SearchUsers({this.user});

  final User user;

  @override
  _SearchUsersState createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('Loading...');
          List<DocumentSnapshot> users = snapshot.data.documents;
          if (userController.allUsersAreMyFriends(widget.user, users)) return Text("hehe");
          return Scaffold(
            backgroundColor: Colors.purple[700],
            body: ListView.builder(
                itemCount: users.length,
                // ignore: missing_return
                itemBuilder: (BuildContext context, int index) {
                  if (userController.isMe(widget.user.uid, users[index]["uid"]) && !friendController.isFriend(widget.user, users[index]["uid"])) {
                    return GestureDetector(
                      onTap: () {
                        _showDialog(users[index], users[index]["uid"]);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            users[index]["photoUrl"]),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                users[index]["displayName"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Bratsy',
                                    fontSize: 40,
                                    height: 1.3),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }
                }),
          );
        });
  }

  void _invite(User user, String uid) {
    invitationService.invite(user, uid);
  }

  void _showDialog(DocumentSnapshot snapshot, String uid) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content:
            Text("Envoyer une demande d'ajout d'ami à ${snapshot["displayName"]}"),
            actions: <Widget>[
              FlatButton(
                child: Text('NIQUE TA MERE'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('DE OUF'),
                onPressed: () {
                  print("inviting....");
                  _invite(widget.user, uid);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchUsers(user: widget.user)));
                },
              ),
            ],
          );
        });
  }
}
