import 'package:coffee_app/data/cart.dart';
import 'package:coffee_app/data/menuitem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Ordertile extends StatefulWidget {
  final Cart cart;
  const Ordertile({super.key, required this.cart});

  @override
  State<Ordertile> createState() => _OrdertileState();
}

class _OrdertileState extends State<Ordertile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Menuitem>(
      builder: (context, menuItem, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          widget.cart.item.imagePath,
                          scale: 20,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            widget.cart.item.name,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'x ${widget.cart.quantity.toString()}',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.cart.formattedPrice,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Colors.red.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Additional: ",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.cart.selectedAddon.isNotEmpty
                        ? widget.cart.selectedAddon
                            .map((addon) => addon.name)
                            .join(', ')
                        : '-',
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                ],
              ),
              Divider(thickness: 1.5),
            ],
          ),
        );
      },
    );
  }
}
