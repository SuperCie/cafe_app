import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Userprovider extends ChangeNotifier{
  Map<String, dynamic>? _userData;

  Map<String, dynamic>? get userData => _userData;

   Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    _userData = snapshot.data();
    notifyListeners();
  }

   void clearUserData() {
    _userData = null;
    notifyListeners();
  }
}