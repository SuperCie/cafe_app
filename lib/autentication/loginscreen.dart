import 'package:coffee_app/models/components/googlebutton.dart';
import 'package:coffee_app/models/components/mybutton.dart';
import 'package:coffee_app/models/components/myformfield.dart';
import 'package:coffee_app/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Loginscreen extends StatefulWidget {
  void Function()? onpressed;
  Loginscreen({super.key, required this.onpressed});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  // panggil authservice yang sudah di buat
  final Authserviceclass _auth = Authserviceclass();
  // controller form
  final passController = TextEditingController();
  final emailController = TextEditingController();
  // validator key
  final GlobalKey<FormState> keyValidator = GlobalKey<FormState>();
  //  components
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: keyValidator,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //upper UI
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign In',
                      style: GoogleFonts.roboto(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Welcome back to the app,',
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Myformfield(
                      controller: emailController,
                      text: 'E-mail',
                      validator: (value) {
                        if (value!.contains('@') && value!.endsWith('.com')) {
                          return null;
                        } else {
                          return 'Email tidak sesuai';
                        }
                      },
                      prefixIcon: Icon(Icons.email_rounded),
                      labelStyle: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    //name
                    Myformfield(
                      controller: passController,
                      text: 'Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icon(Icons.password_rounded),
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
                      obscureText: hidePassword,
                      labelStyle: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.roboto(
                              fontSize: 22,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Mybutton(
                      ontap: () {
                        if (keyValidator.currentState!.validate()) {
                          // panggil function signin
                          _auth.signInUserAccount(
                            emailController.text,
                            passController.text,
                            context,
                          );
                        }
                      },
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.roboto(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Center(
                  child: Text(
                    'or',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    Googlebutton(
                      ontap: () => Authserviceclass().signInwithGoogle(context),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: widget.onpressed,
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
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
