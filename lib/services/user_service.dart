import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final Firestore _db = Firestore.instance;

  Future<DocumentSnapshot> getUser(String uid) async {
    return _db.collection('users').document(uid).get();
  }
}

final UserService userService = UserService();