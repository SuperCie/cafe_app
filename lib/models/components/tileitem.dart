import 'package:coffee_app/data/item.dart';
import 'package:coffee_app/screens/itempage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Tileitem extends StatelessWidget {
  final Item items;

  Tileitem({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Itempage(items: items)),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.5,
              color: Theme.of(context).colorScheme.secondary,
            ),
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Hero(
                tag: items.imagePath,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    items.imagePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    items.name,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    items.formattedPrice,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
