import 'package:coffee_app/data/paymeths.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Paymenttile extends StatelessWidget {
  final Paymeths paymeths;
  final VoidCallback ontap;
  Paymenttile({super.key, required this.paymeths, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            border: Border.all(width: 1.0),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Image.asset(paymeths.imagePath, scale: 15),
            title: Text(
              'Transfer Bank ${paymeths.name}',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
