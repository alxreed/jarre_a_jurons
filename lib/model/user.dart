import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jarreajurons/model/friend.dart';

class User {
  String uid;
  String name;
  String email;
  Timestamp lastSeen;
  String photoUrl;
  List<Friend> friends;

  User(DocumentSnapshot snapshot) {
    print(snapshot);
    Map<String, dynamic> map = snapshot.data;
    uid = map["uid"];
    name = map["displayName"];
    email = map["email"];
    friends = generateFriend(map["friends"]);
    lastSeen = map["lastSeen"];
    photoUrl = map["photoUrl"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "dislayName": name,
      "email": email,
      "lastSeen": lastSeen,
      "photoUrl": photoUrl
    };
  }

  List<Friend> generateFriend(List<dynamic> list) {
    List<Friend> listOfFriends = new List<Friend>();
    list.forEach((friendMap) {
      Friend friend = new Friend(friendMap);
      listOfFriends.add(friend);
    });
    return listOfFriends;
  }
}