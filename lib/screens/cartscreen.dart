import 'package:coffee_app/data/cart.dart';
import 'package:coffee_app/data/item.dart';
import 'package:coffee_app/data/menuitem.dart';
import 'package:coffee_app/models/components/carttile.dart';
import 'package:coffee_app/models/components/containermodel.dart';
import 'package:coffee_app/models/components/myformfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Cartscreen extends StatelessWidget {
  const Cartscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reNoteController = TextEditingController();
    final _scrollController = ScrollController();

    return Consumer<Menuitem>(
      builder: (context, menuItem, child) {
        final userCart = menuItem.cart;

        // untuk kalau misalny kalau cart itemnya kosong maka akan lsg meninggalkan screen
        if (userCart.isEmpty) {
          Future.microtask(() => Navigator.pop(context));
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,

          appBar: AppBar(
            title: Text(
              'Cart',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.store_rounded),
                      SizedBox(width: 10),
                      Text(
                        'Choose your store',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Containermodel(
                    widget: Text(
                      'Kopi Soe Pekanbaru',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(thickness: 1.5),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.list_alt_rounded),
                          SizedBox(width: 10),
                          Text(
                            'Your item',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () => menuItem.deleteAllCart(),
                        child: Text(
                          'Delete All',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: userCart.length,
                    itemBuilder: (context, index) {
                      final cartItem = userCart[index];
                      return Carttile(cart: cartItem);
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.note_alt_outlined),
                      SizedBox(width: 10),
                      Text(
                        'Note for restaurant',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Myformfield(
                    controller: reNoteController,
                    text: 'Add your note to restaurant',
                    validator: (value) {
                      return null;
                    },
                    ontap: () {
                      Future.delayed(Duration(milliseconds: 300), () {
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.payment_outlined),
                      SizedBox(width: 10),
                      Text(
                        'Payment Method',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Containermodel(
                    widget: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/images/bcaicon.png', scale: 15),
                            Text(
                              'Transfer Bank - Bank BCA',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.receipt_long_rounded),
                      SizedBox(width: 10),
                      Text(
                        'Payment Details',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Containermodel(
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              menuItem.formattedTCP,
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Admin Fee',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              menuItem.formattedAdmin,
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Payment',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              menuItem.formattedTTA,
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 70),
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
            height: 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Checkout',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.red,
                    width: 100,
                    height: double.infinity,
                    child: Center(
                      child: Text(
                        'Pay',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
