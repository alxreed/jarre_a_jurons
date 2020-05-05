import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jarreajurons/model/friend.dart';
import 'package:jarreajurons/model/user.dart';

class FriendService {

  final Firestore _db = Firestore.instance;

  Future updateMoneyEarned(User user, Friend friend, int amount) async {
    DocumentReference ref = _db.collection('users').document(user.uid);
    List<dynamic> friends = new List<dynamic>();
    user.friends.forEach((f) {
      HashMap<dynamic, dynamic> map = new HashMap<dynamic, dynamic>();
      if(f.uid == friend.uid) {
        map["uid"] = f.uid;
        map["name"] = f.name;
        map["photoUrl"] = f.photoUrl;
        map["moneyEarned"] = amount;
        friends.add(map);
      } else {
        map["uid"] = f.uid;
        map["name"] = f.name;
        map["photoUrl"] = f.photoUrl;
        map["moneyEarned"] = f.moneyEarned;
        friends.add(map);
      }
    });
    return await ref.updateData({'friends': friends});
  }

}

final FriendService friendService = new FriendService();