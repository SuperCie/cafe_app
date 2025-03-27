import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Orderhistory {
  final String orderId;
  final String customerId;
  final String customerName;
  final String storeName;
  final String note;
  final String payment;
  final int total;
  final List<Map<String, dynamic>> detailItem;

  Orderhistory({
    required this.orderId,
    required this.customerId,
    required this.customerName,
    required this.storeName,
    required this.note,
    required this.payment,
    required this.total,
    required this.detailItem,
  });

  factory Orderhistory.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Orderhistory(
      orderId: doc.id,
      customerId: data['userID'] ?? '',
      customerName: data['name'] ?? 'Unknown',
      storeName: data['storeName'] ?? 'Unknown',
      note: data['note'] ?? '',
      payment: data['payment'] ?? '',

      total: (data['total'] as num).toInt(),
      detailItem: List<Map<String, dynamic>>.from(data['item'] ?? []),
    );
  }
}
