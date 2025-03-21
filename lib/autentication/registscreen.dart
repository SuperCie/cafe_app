import 'package:coffee_app/models/components/googlebutton.dart';
import 'package:coffee_app/models/components/mybutton.dart';
import 'package:coffee_app/models/components/myformfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Registscreen extends StatefulWidget {
  const Registscreen({super.key});

  @override
  State<Registscreen> createState() => _RegistscreenState();
}

class _RegistscreenState extends State<Registscreen> {
  @override
  Widget build(BuildContext context) {
    // controller form
    final nameController = TextEditingController();
    final passController = TextEditingController();
    final emailController = TextEditingController();
    final birthController = TextEditingController();

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
                style: GoogleFonts.roboto(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Already have an account?',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 20),
              //name
              Myformfield(
                controller: nameController,
                text: 'Name',
                validator: (p0) {},
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
                validator: (p0) {},
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
                validator: (p0) {},
                prefixIcon: Icon(Icons.password_rounded),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.visibility),
                ),
                obscureText: true,
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
                validator: (p0) {},
                readOnly: true,
                ontap: () {},
                prefixIcon: Icon(Icons.calendar_month_rounded),
                labelStyle: GoogleFonts.roboto(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Mybutton(
                ontap: () {},
                child: Text(
                  'Create Account',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  'or',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Googlebutton(ontap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
