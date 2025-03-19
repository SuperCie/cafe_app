import 'package:coffee_app/models/components/tilemodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    void logout() {}

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'PROFILE',
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
        child: ListView(
          children: [
            Tilemodel(
              text: 'Personal',
              imagePath: 'assets/icons/personicon.png',
            ),
            Divider(thickness: 1.0),

            Tilemodel(
              text: 'Transaction History',
              imagePath: 'assets/icons/transactionicon.png',
            ),
            Divider(thickness: 1.0),
          ],
        ),
      ),
    );
  }
}
