import 'package:coffee_app/data/cart.dart';
import 'package:coffee_app/data/menuitem.dart';
import 'package:coffee_app/models/components/quantitymodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Carttile extends StatelessWidget {
  final Cart cart;

  Carttile({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Consumer<Menuitem>(
      builder:
          (context, menuItem, child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Hero(
                              tag: cart.item.imagePath,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.asset(
                                  cart.item.imagePath,
                                  width: 70,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cart.item.name,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                if (cart.selectedAddon.isNotEmpty)
                                  Row(
                                    children:
                                        cart.selectedAddon
                                            .map(
                                              (addon) => SizedBox(
                                                width: 70,
                                                child: Text(
                                                  addon.name + ' ',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                  ),
                                SizedBox(height: 10),
                                Text(
                                  cart.formattedPrice,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            // quantity
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Ubah',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Quantitymodel(
                            quantity: cart.quantity,
                            item: cart.item,
                            onDecrement: () {
                              menuItem.deleteCart(cart);
                            },
                            onIncrement: () {
                              menuItem.addCartItem(
                                cart.item,
                                cart.selectedAddon,
                              );
                            },
                          ),
                        ],
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
