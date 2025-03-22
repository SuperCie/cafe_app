import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void successMsg(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green.shade800,
      content: Center(
        child: Text(
          message,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    ),
  );
}
