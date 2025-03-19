import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  Store({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

Future<List<Store>> getStoresFromFirestore() async {
  final firestore = FirebaseFirestore.instance;
  final snapshot = await firestore.collection('stores').get();

  return snapshot.docs.map((doc) {
    return Store(
      id: doc.id,
      name: doc['name'],
      address: doc['address'],
      latitude: doc['latitude'],
      longitude: doc['longitude'],
    );
  }).toList();
}
