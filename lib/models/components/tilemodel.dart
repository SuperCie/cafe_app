import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tilemodel extends StatelessWidget {
  final String text;
  final String imagePath;
  const Tilemodel({super.key, required this.text, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      trailing: Image.asset(imagePath, height: 30, width: 30),
    );
  }
}
