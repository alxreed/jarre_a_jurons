import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jarreajurons/controllers/friend_controller.dart';
import 'package:jarreajurons/controllers/invitation_controller.dart';
import 'package:jarreajurons/controllers/user_controller.dart';
import 'package:jarreajurons/my_profile.dart';

import 'model/invitation.dart';
import 'model/user.dart';

class Invitations extends StatefulWidget {
  Invitations({Key key, this.user}) : super(key: key);

  final User user;

  @override
  _InvitationsState createState() => _InvitationsState();
}

class _InvitationsState extends State<Invitations> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(builder: (context, snapshot) {
      List<Invitation> invitations = widget.user.invitations;
      return Scaffold(
        backgroundColor: Colors.purple[700],
        body: Column(
          children: <Widget>[
            Center(
              child: Text(
                "Mes demandes d'ajout",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontFamily: 'Bratsy',
                    fontSize: 40,
                    height: 2.5),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: invitations.length,
                  // ignore: missing_return
                  itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _acceptInvite(invitations[index]);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            if (index > 0)
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
                                              invitations[index].userPhoto),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  invitations[index].name,
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
                  }),
            )
          ],
        ),
      );
    });
  }

  void _acceptInvite(Invitation invitation) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content:
                Text("Envoyer une demande d'ajout d'ami à ${invitation.name}"),
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
                  userController.addFriend(widget.user, invitation);
                  invitationController.turnOffInvite(widget.user, invitation);
                  friendController.addMeAsFriend(widget.user, invitation);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyProfile(user: widget.user)));
                },
              ),
            ],
          );
        });
  }
}
