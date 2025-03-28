import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/autentication/authgate.dart';
import 'package:coffee_app/data/database/userprovider.dart';
import 'package:coffee_app/models/components/mybutton.dart';
import 'package:coffee_app/models/components/myformfield.dart';
import 'package:coffee_app/screens/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Completeprofile extends StatefulWidget {
  final String email;
  final String uid;
  const Completeprofile({super.key, required this.email, required this.uid});

  @override
  State<Completeprofile> createState() => _CompleteprofileState();
}

class _CompleteprofileState extends State<Completeprofile> {
  final birthController = TextEditingController();
  final nameController = TextEditingController();
  final GlobalKey<FormState> keyValidator = GlobalKey<FormState>();

  DateTime? selectedDate;

  void pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.black,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
            ),
          ),

          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        birthController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  Future<void> saveUserData() async {
    if (keyValidator.currentState!.validate()) {
      try {
        final userProvider = Provider.of<Userprovider>(context, listen: false);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .set({
              'uid': widget.uid,
              'name': nameController.text,
              'email': widget.email,
              'datebirth': birthController.text,
              'createdAt': FieldValue.serverTimestamp(),
            });

        await userProvider.fetchUserData();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Authgate()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: keyValidator,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Complete Your Profile',
                      style: GoogleFonts.roboto(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Hi, ${widget.email}',
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    //name
                    Myformfield(
                      controller: nameController,
                      text: 'Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama tidak boleh kosong';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icon(Icons.person),
                      labelStyle: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    //name
                    Myformfield(
                      controller: birthController,
                      text: 'Date of Birth',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Data tanggal lahir tidak boleh kosong';
                        } else {
                          return null;
                        }
                      },
                      readOnly: true,
                      ontap: pickDate,
                      prefixIcon: Icon(Icons.calendar_month_rounded),
                      labelStyle: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Mybutton(
                      ontap: () => saveUserData(),
                      child: Text(
                        'Save',
                        style: GoogleFonts.roboto(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
