import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/autentication/authgate.dart';
import 'package:coffee_app/autentication/helper/displayerror.dart';
import 'package:coffee_app/autentication/helper/displayproceed.dart';
import 'package:coffee_app/autentication/helper/scaffoldmessager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authserviceclass {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // BY EMAIL
  // register user method
  Future<User?> registerUserAccount(
    String name,
    String email,
    String password,
    String dateBirth,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // untuk menyimpan data user yang akan signup ke aplikasi
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'name': name,
            'email': email,
            'datebirth': dateBirth,
            'createdAt': DateTime.now(),
          },
        ); // artinya kalau datanya itu tidak kosong, kita buatkan dia kedalam database dengan nama collectionnya itu Users.
        // terus disimpan berdasarkan uid unik masing" dan data yang akan disimpan berupa nama, email, tanggal lahir dan kapan dibuat
        successMsg(context, 'Your account successfuly registered');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Authgate()),
        );
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      displayError(context, e.toString());
    }
  }

  // login user methode
  Future<User?> signInUserAccount(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      successMsg(context, 'Welcome Back, You successfuly signed in');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Authgate()),
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      displayError(context, e.toString());
    }
  }

  // LOGOUT
  Future<void> userLogOut(BuildContext context) async {
    try {
      displayProceed(
        context: context,
        title: 'Logout Confirmation',
        message:
            "Are you sure you want to sign out? You'll need to log in again to access your account.",
        cancelMessage: 'Stay on app',
        cancelTap: () {
          Navigator.pop(context);
        },
        confirmMessage: 'Logout',
        confirmTap: () async {
          Navigator.pop(context);
          await _auth.signOut();

          successMsg(context, 'Signed out successfully. See you again!');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Authgate()),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      displayError(context, e.toString());
    }
  }

  // DELETE ACCOUNT
  Future<void> deleteUserAccount(BuildContext context, String password) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        displayProceed(
          context: context,
          // title
          title: 'Delete Confirmation',
          // content
          message:
              'Are you sure you want to delete your account? This action cannot be undone.',
          // cancel button message
          cancelMessage: 'Stay on app',
          // cancel button function
          cancelTap: () {
            Navigator.pop(context);
          },
          // confirm button message
          confirmMessage: 'Delete',
          // confirm button function
          confirmTap: () async {
            // Reautentikasi pengguna
            AuthCredential credential = EmailAuthProvider.credential(
              email: user.email!,
              password: password,
            );
            await user.reauthenticateWithCredential(credential);

            // tutup dialog konfirmasi
            Navigator.pop(context);
            // Hapus data pengguna dari Firestore
            await _firestore.collection('users').doc(user.uid).delete();

            // Hapus akun pengguna dari Firebase Auth
            await user.delete();

            // pesan sukses :
            successMsg(context, 'Your account has been deleted');

            // arahkan ke halaman awal app
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Authgate()),
            );
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      displayError(context, e.toString());
    }
  }

  // Stream for Auth state change
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // untuk mengambil data user dari firestore
  Future<Map<String, dynamic>?> getUserData(
    String uid,
    BuildContext context,
  ) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(uid).get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      displayError(context, e.toString());
      return null;
    }
  }
}
