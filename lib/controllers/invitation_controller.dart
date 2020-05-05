import 'package:jarreajurons/model/invitation.dart';
import 'package:jarreajurons/model/user.dart';
import 'package:jarreajurons/services/invitation_service.dart';

class InvitationController {
  void turnOffInvite(User user, Invitation invitation) {
    invitation.turnOff();
    invitationService.turnOffInvite(user, invitation);
  }
}

final InvitationController invitationController = new InvitationController();
