import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jarreajurons/model/friend.dart';
import 'package:jarreajurons/model/user.dart';

class UserService {
  Firestore _db = Firestore.instance;

  void getAllusers() {
    CollectionReference allUsers = _db.collection('users');
  }

  Future addFriendInDB(User user, Friend newFriend) async {
    DocumentReference ref = _db.collection('users').document(user.uid);
    var friend = [
      {
        "moneyEarned": newFriend.moneyEarned,
        "name": newFriend.name,
        "photoUrl": newFriend.photoUrl,
        "uid": newFriend.uid
      }
    ];

    return await ref.updateData({"friends": FieldValue.arrayUnion(friend)});
  }

  Future<DocumentSnapshot> getUser(String uid) async {
    return await _db.collection('users').document(uid).get();
  }

}

final UserService userService = UserService();
