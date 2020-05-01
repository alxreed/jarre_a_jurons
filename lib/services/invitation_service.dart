import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
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
}

final InvitationService invitationService = new InvitationService();
