import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  Firestore _db = Firestore.instance;

  void getAllusers() {
   CollectionReference allUsers = _db.collection('users');
  }

}

final UserService userService = UserService();