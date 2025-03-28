import 'package:coffee_app/autentication/handler.dart';
import 'package:coffee_app/screens/homescreen.dart';
import 'package:coffee_app/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authgate extends StatelessWidget {
  final Authserviceclass _auth = Authserviceclass();
  Authgate({super.key});

  @override
  Widget build(BuildContext context) {
    print("FirebaseAuth user: ${FirebaseAuth.instance.currentUser}");
    return StreamBuilder<User?>(
      stream: _auth.user,
      builder: (context, snapshot) {
        print("AuthGate - Snapshot data: ${snapshot.data}");
        print("AuthGate - User ID: ${snapshot.data?.uid}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (snapshot.hasData) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Homescreen()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Handler()),
              );
            }
          });
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
