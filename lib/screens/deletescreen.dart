import 'package:coffee_app/autentication/helper/displayerror.dart';
import 'package:coffee_app/models/components/mybutton.dart';
import 'package:coffee_app/models/components/myformfield.dart';
import 'package:coffee_app/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Deletescreen extends StatefulWidget {
  const Deletescreen({super.key});

  @override
  State<Deletescreen> createState() => _DeletescreenState();
}

class _DeletescreenState extends State<Deletescreen> {
  final Authserviceclass _auth = Authserviceclass();

  final passwordController = TextEditingController();

  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Delete Account',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Please enter your password to confirm account deletion',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Myformfield(
                  controller: passwordController,
                  text: 'Re-enter Password',
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon:
                        hidePassword
                            ? Icon(Icons.visibility_off_rounded)
                            : Icon(Icons.visibility),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Mybutton(
              child: Text(
                'Continue',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              ontap: () async {
                String password = passwordController.text;
                if (password.isEmpty) {
                  displayError(context, "Password field can't be empty!");
                  return;
                }

                // Lakukan reautentikasi
                try {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    AuthCredential credential = EmailAuthProvider.credential(
                      email: user.email!,
                      password: password,
                    );
                    await user.reauthenticateWithCredential(credential);

                    await _auth.deleteUserAccount(context, password);
                  }
                } on FirebaseAuthException catch (e) {
                  // Jika password salah atau terjadi error
                  displayError(context, "Invalid password. Please try again.");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
