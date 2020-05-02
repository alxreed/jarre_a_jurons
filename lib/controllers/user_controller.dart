import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jarreajurons/model/friend.dart';
import 'package:jarreajurons/model/invitation.dart';
import 'package:jarreajurons/model/user.dart';
import 'package:jarreajurons/services/user_service.dart';

class UserController {
  bool isMe(String myUid, String userUid) {
    return myUid == userUid;
  }

  bool allUsersAreMyFriends(User me, List<DocumentSnapshot> users) {
    bool allUsersAreMyfriends = true;
    List<String> myFriendsUid = new List();
    me.friends.forEach((friend) => myFriendsUid.add(friend.uid));
    users.forEach((user) {
      if (!myFriendsUid.contains(user["uid"]) && user["uid"] != me.uid) {
        allUsersAreMyfriends = false;
      }
    });
    return allUsersAreMyfriends;
  }

  void addFriend(User user, Invitation invitation) {
    Friend newFriend = Friend.fromInvitation(invitation);
    user.addFriend(newFriend);
    userService.addFriendInDB(user, newFriend);
  }

  User getUser(String uid) {
    return userService.getUser(uid);
  }
}

final UserController userController = new UserController();