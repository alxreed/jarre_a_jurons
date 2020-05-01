import 'package:jarreajurons/model/user.dart';

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
}

final FriendController friendController = new FriendController();