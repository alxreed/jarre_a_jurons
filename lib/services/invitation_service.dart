import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jarreajurons/model/invitation.dart';
import 'package:jarreajurons/model/user.dart';

class InvitationService {
  Firestore _db = Firestore.instance;

  Future invite(User user, String uid) async {
    DocumentReference ref = _db.collection('users').document(uid);
    var invite = [
      {
        "accepted": false,
        "userUid": user.uid,
        "name": user.name,
        "userPhoto": user.photoUrl
      }
    ];

    return await ref
        .updateData({"invitations": FieldValue.arrayUnion(invite)});
  }

  Future turnOffInvite(User user, Invitation invitation) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    List<dynamic> invitations = new List<dynamic>();
    user.invitations.forEach((i) {
      HashMap<dynamic, dynamic> map = new HashMap<dynamic, dynamic>();
      if(i.userUid == invitation.userUid) {
        map["userUid"] = i.userUid;
        map["name"] = i.name;
        map["userPhoto"] = i.userPhoto;
        map["accepted"] = true;
        invitations.add(map);
      } else {
        map["userUid"] = i.userUid;
        map["name"] = i.name;
        map["userPhoto"] = i.userPhoto;
        map["accepted"] = i.accepted;
        invitations.add(map);

      }
    });
    return await ref.updateData({'invitations': invitations});
  }

  List<Invitation> removeAcceptedInvite(List<Invitation> invitations) {
    return invitations.where((invitation) => !invitation.accepted).toList();
  }
}

final InvitationService invitationService = new InvitationService();
