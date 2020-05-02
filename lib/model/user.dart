import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jarreajurons/model/friend.dart';

import 'invitation.dart';

class User {
  String uid;
  String name;
  String email;
  Timestamp lastSeen;
  String photoUrl;
  List<Friend> friends;
  List<Invitation> invitations;

  User(DocumentSnapshot snapshot) {
    print(snapshot);
    Map<String, dynamic> map = snapshot.data;
    uid = map["uid"];
    name = map["displayName"];
    email = map["email"];
    friends = generateFriend(map["friends"]);
    invitations = generateInvitation(map["invitations"]);
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
    if (list != null) {
      list.forEach((friendMap) {
        Friend friend = new Friend(friendMap);
        listOfFriends.add(friend);
      });
    }
    return listOfFriends;
  }

  List<Invitation> generateInvitation(List<dynamic> list) {
    List<Invitation> listOfInvitations = new List<Invitation>();
    if (list != null) {
      list.forEach((invitationMap) {
        Invitation invitation = new Invitation(invitationMap);
        listOfInvitations.add(invitation);
      });
    }
    return listOfInvitations;
  }

  bool isMe(String otherUid) {
    return this.uid == otherUid;
  }

  bool isMyFriend(String uid) {
    bool isMyFriend = false;
    this.friends.forEach((friend) {
      if (friend.uid == uid) {
        isMyFriend = true;
      }
    });

    return isMyFriend;
  }

  bool hasInvitations() {
    bool hasInvitations = false;
    this.invitations.forEach((invitation) {
      if (invitation.accepted == false) {
        hasInvitations = true;
      }
    });
    return hasInvitations;
  }

  void addFriend(Friend newFriend) {
    this.friends.add(newFriend);
  }

}