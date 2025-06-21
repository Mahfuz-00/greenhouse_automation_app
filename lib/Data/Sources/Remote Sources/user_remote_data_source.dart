import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Models/user_model.dart';

class UserRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toJson());
  }

  Future<void> updateUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).update(user.toJson());
  }

  Future<void> deleteUser(String id) async {
    await _firestore.collection('users').doc(id).delete();
  }

  Future<UserModel?> loginUser(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    if (credential.user != null) {
      final doc = await _firestore.collection('users').doc(credential.user!.uid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
    }
    return null;
  }

  Future<void> signupUser(UserModel user, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(email: user.email, password: password);
    final userModel = UserModel.fromEntity(user.copyWith(id: credential.user!.uid));
    await addUser(userModel);
  }
}