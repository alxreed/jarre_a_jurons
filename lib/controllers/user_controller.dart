import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jarreajurons/model/user.dart';
import 'package:jarreajurons/services/user_service.dart';

/*
class UserController {
 User getUser(String uid) {
   User user = new User();
   user.name = 'Michel';
   Map<String, dynamic> userDocument;
   Future<DocumentSnapshot> dbUser = userService.getUser(uid);
   dbUser.then((DocumentSnapshot ds) {
     print(ds.data);
     userDocument = Map.from(ds.data);
     user.name = userDocument['uid'];
     print(user.name);
     return user;
   });
   return user;
 }
}*/
