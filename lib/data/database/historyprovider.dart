import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/data/database/orderhistory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Historyprovider extends ChangeNotifier {
  List<Orderhistory>? _listOrder;

  List<Orderhistory>? get listOrder => _listOrder;

  Stream<List<Orderhistory>> getOrderedHistoryFromFirestore() {
    final user = FirebaseAuth.instance.currentUser;
    if(user ==null) return Stream.value([]);

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transaction')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (event) =>
              event.docs.map((doc) => Orderhistory.fromFirestore(doc)).toList(),
        );
  }
}
