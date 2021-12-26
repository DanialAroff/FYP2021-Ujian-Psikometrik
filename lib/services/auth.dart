// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp1/models/user.dart';
import 'package:fyp1/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser _currentUser;
  MyUser get currentUser => _currentUser;

  Future _populateCurrentUser(User user) async {
    if (user != null) {
      DatabaseService db = DatabaseService();
      _currentUser = await db.getUser;
    }
  }

  // create user
  MyUser _user(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<MyUser> get user {
    return _auth.authStateChanges().map(_user);
  }

  // Log in Anonymously
  Future logInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _user(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Login with email & password
  Future logInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await _populateCurrentUser(result.user);
      User user = result.user;
      // return _user(user);
      return _user(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      String name = 'name';
      String role = 'admin';
      // create a new document for the user with uid
      await DatabaseService(uid: user.uid).updateUserData(email, name, role);
      return MyUser(
          uid: user.uid, fullName: name, email: email, userRole: role);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Log out
  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
