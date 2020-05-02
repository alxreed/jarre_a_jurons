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

  User getUser(String uid) {
    User user;
    _db.collection('users').document(uid).snapshots().listen((snapshot) {
      print(snapshot.data);
      user = User(snapshot);
    });
    print(user);
    return user;
  }

}

final UserService userService = UserService();
