import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class FirestoreMapService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<LatLng>> getLocation() async {
    List<LatLng> locations = [];

    try {
      QuerySnapshot snapshot = await _firestore.collection('stores').get();
      for (var doc in snapshot.docs) {
        double latitude = doc['latitude'];
        double longitude = doc['longitude'];
        locations.add(LatLng(latitude, longitude));
      }
    } catch (e) {
      print("Error fetching location: $e");
    }

    return locations;
  }
}
