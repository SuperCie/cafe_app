import 'package:cloud_firestore/cloud_firestore.dart';

class Paymeths {
  final String id;
  final String name;
  final String imagePath;

  Paymeths({required this.id, required this.name, required this.imagePath});
}

Future<List<Paymeths>> getPayMethodsFirestore() async {
  final firestore = FirebaseFirestore.instance;
  final snapshot = await firestore.collection('paymethod').get();

  return snapshot.docs.map((data) {
    return Paymeths(
      id: data.id,
      name: data['name'],
      imagePath: data['imagePath'],
    );
  }).toList();
}
