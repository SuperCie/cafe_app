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
  return  StreamBuilder<User?>(stream: _auth.user, builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting){
      return Center(child: CircularProgressIndicator(),);
    } else {
      if(snapshot.hasData) {
        return Homescreen();
      } else {
        return Handler();
      }
    }
  },);
  }
}