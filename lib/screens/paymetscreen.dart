import 'package:coffee_app/data/paymeths.dart';
import 'package:coffee_app/models/components/paymenttile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Paymetscreen extends StatefulWidget {
  const Paymetscreen({super.key});

  @override
  State<Paymetscreen> createState() => _PaymetscreenState();
}

class _PaymetscreenState extends State<Paymetscreen> {
  Paymeths? selectedMethods;

  void selectPayment(BuildContext context, Paymeths methods) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Confirm Payment Method',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            content: ListTile(
              leading: Image.asset(methods.imagePath, scale: 15),
              title: Text(
                'Transfer Bank ${methods.name}',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.0),
                  ),
                  child: Text(
                    "Change Payment",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context, methods);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.shade800,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.0),
                  ),
                  child: Text(
                    "Confirm",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose Payment Methods',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getPayMethodsFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Cashless payment options are currently unavailable"),
            );
          }
          final paymethods = snapshot.data;
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: paymethods!.length,
            itemBuilder: (context, index) {
              return Paymenttile(
                paymeths: paymethods[index],
                ontap: () => selectPayment(context, paymethods[index]),
              );
            },
          );
        },
      ),
    );
  }
}
