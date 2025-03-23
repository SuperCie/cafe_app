import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Historytrans extends StatelessWidget {
  const Historytrans({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'History List',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.all(20),

        width: MediaQuery.of(context).size.width,

        height: MediaQuery.of(context).size.height,

        child: Text('Test'),
      ),
    );
  }
}
