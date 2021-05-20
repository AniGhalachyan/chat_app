import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/model/user.dart';

class AuthMethods {
  File image;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users _usersFromFirebaseUser(User user) {
    return user != null ? Users(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = res.user;
      return _usersFromFirebaseUser(firebaseUser);
    } catch (error) {
      print(error);
    }
  }

  Future createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User firebaseUser = res.user;

      return _usersFromFirebaseUser(firebaseUser);
    } catch (error) {
      print(error);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error);
    }
  }
}
