import 'package:jarreajurons/controllers/user_controller.dart';
import 'package:jarreajurons/model/friend.dart';
import 'package:jarreajurons/model/invitation.dart';
import 'package:jarreajurons/model/user.dart';
import 'package:jarreajurons/services/user_service.dart';

class FriendController {
  bool isFriend(User user, String friendUid) {
    bool isFriend = false;
    user.friends.forEach((friend) {
      if (friend.uid == friendUid) {
        isFriend = true;
      }
    });
    return isFriend;
  }

  void addMeAsFriend(User user, Invitation invitation) {
    Friend meAsFriend = Friend.fromUser(user);
    User myFriendAsUser = userController.getUser(invitation.userUid);
    userService.addFriendInDB(myFriendAsUser, meAsFriend);
  }
}

final FriendController friendController = new FriendController();