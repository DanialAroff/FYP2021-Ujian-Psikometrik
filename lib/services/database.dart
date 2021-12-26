import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp1/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference scoreIKK = FirebaseFirestore.instance
      .collection('skor_inventori_kematangan_kerjaya');
  final CollectionReference scoreITP =
      FirebaseFirestore.instance.collection('skor_inventori_trait_personaliti');
  final CollectionReference scoreIMK =
      FirebaseFirestore.instance.collection('skor_inventori_minat_kerjaya');

  Future updateUserData(String email, String name, String role) async {
    return await userCollection.doc(uid).set({
      'email': email,
      'name': name,
      'user_role': role,
    });
  }

  // Get users stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  // Get the current user logged in
  Stream<DocumentSnapshot> get currentUser {
    return userCollection.doc(uid).snapshots();
  }

  Stream<DocumentSnapshot> get currentUserIKKScore {
    try {
      return scoreIKK.doc(uid).snapshots();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Stream<DocumentSnapshot> get currentUserITPScore {
    try {
      return scoreITP.doc(uid).snapshots();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Stream<DocumentSnapshot> get currentUserIMKScore {
    try {
      return scoreIMK.doc(uid).snapshots();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<QuerySnapshot> get itemsIKK async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('inventori_kematangan_kerjaya');
    return await collection.get();
  }
//  Stream<QuerySnapshot> get itemsIKKs {
//     CollectionReference collection =
//         FirebaseFirestore.instance.collection('inventori_kematangan_kerjaya');
//     return collection.snapshots();
//   }

  Future<MyUser> get getUser async {
    try {
      DocumentSnapshot userData = await userCollection.doc(uid).get();
      return MyUser.fromData(userData.data());
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Stream<MyUser> get userData {
    return userCollection
        .doc(uid)
        .snapshots()
        .map((snapshot) => MyUser.fromMap(snapshot.data()));
  }
}
