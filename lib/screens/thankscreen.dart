import 'package:coffee_app/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Thankscreen extends StatefulWidget {
  const Thankscreen({super.key});

  @override
  State<Thankscreen> createState() => _ThankscreenState();
}

class _ThankscreenState extends State<Thankscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/done_lottie.json',
              frameRate: FrameRate(120),
              fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Thank You For Your Order',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Your Order is Being Processed',
              style: GoogleFonts.montserrat(fontSize: 16),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
