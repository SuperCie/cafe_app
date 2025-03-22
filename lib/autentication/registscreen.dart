import 'package:coffee_app/models/components/googlebutton.dart';
import 'package:coffee_app/models/components/mybutton.dart';
import 'package:coffee_app/models/components/myformfield.dart';
import 'package:coffee_app/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Registscreen extends StatefulWidget {
  void Function()? onpressed;
  Registscreen({super.key, required this.onpressed});

  @override
  State<Registscreen> createState() => _RegistscreenState();
}

class _RegistscreenState extends State<Registscreen> {
  // panggil class auth
  final Authserviceclass _auth = Authserviceclass();
  // controller form
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final emailController = TextEditingController();
  final birthController = TextEditingController();

  // validator key
  final GlobalKey<FormState> keyValidator = GlobalKey<FormState>();
  //  components
  bool hidePassword = true;
  DateTime? selectedDate;

  // datepicker
  void pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        birthController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}"; // Format bisa disesuaikan
      });
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
                      'Sign Up',
                      style: GoogleFonts.roboto(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Welcome to the app',
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
                    //
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
                      ontap: () {
                        if (keyValidator.currentState!.validate()) {
                          _auth.registerUserAccount(
                            nameController.text,
                            emailController.text,
                            passController.text,
                            birthController.text,
                            context,
                          );
                        }
                      },
                      child: Text(
                        'Create Account',
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
                SizedBox(height: 20),
                Column(
                  children: [
                    Googlebutton(ontap: () {}),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: widget.onpressed,
                          child: Text(
                            'Sign In',
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
