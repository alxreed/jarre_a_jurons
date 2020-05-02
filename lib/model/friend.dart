import 'package:jarreajurons/model/invitation.dart';

class Friend {
  String uid;
  String name;
  String photoUrl;
  int moneyEarned;

  Friend(dynamic map) {
    uid = map["uid"];
    name = map["name"];
    photoUrl = map["photoUrl"];
    moneyEarned = map["moneyEarned"];

  }

  Friend.fromInvitation(Invitation invitation) {
    this.uid = invitation.userUid;
    this.name = invitation.name;
    this.photoUrl = invitation.userPhoto;
    this.moneyEarned = 0;
  }

}
