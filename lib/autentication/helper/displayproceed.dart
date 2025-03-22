import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void displayProceed({
  required BuildContext context,
  required String title,
  required String message,
  required String cancelMessage,
  required void Function()? cancelTap,
  required String confirmMessage,
  required void Function()? confirmTap,
}) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            GestureDetector(
              onTap: cancelTap,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1.0),
                ),
                child: Text(
                  cancelMessage,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: confirmTap,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade800,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1.0),
                ),
                child: Text(
                  confirmMessage,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
  );
}
