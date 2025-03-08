import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Inboxscreen extends StatefulWidget {
  const Inboxscreen({super.key});

  @override
  State<Inboxscreen> createState() => _InboxscreenState();
}

class _InboxscreenState extends State<Inboxscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'INBOX',
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
            Center(
              child: Text(
                'No Message(s) to show',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
