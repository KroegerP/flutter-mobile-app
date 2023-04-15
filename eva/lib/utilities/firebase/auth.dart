import 'package:eva/classes/data_types.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  // _ indicates that it's private - can only be used here
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserType _userFromFirebase(User? user) {
    return UserType(
        uuid: user?.uid ?? '',
        firstName: user?.isAnonymous.toString() ?? 'idk',
        isAnonymous: user?.isAnonymous ?? true);
  }

  // If we call AuthService.user, it will run this function
  Stream<UserType> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signInAnon() async {
    try {
      UserCredential anonResult = await _auth.signInAnonymously();
      return anonResult;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future signIn(String userEmail, String userPassword) async {
    try {
      UserCredential userResult = await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
      return userResult;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
