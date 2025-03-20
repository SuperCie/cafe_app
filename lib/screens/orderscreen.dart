import 'package:coffee_app/data/menuitem.dart';
import 'package:coffee_app/data/paymethprovider.dart';
import 'package:coffee_app/data/storeprovider.dart';
import 'package:coffee_app/models/components/containernopad.dart';
import 'package:coffee_app/models/components/ordertile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:slider_button/slider_button.dart';

class Orderscreen extends StatelessWidget {
  const Orderscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Menuitem>(
      builder: (context, menuItem, child) {
        // get cart data
        final userCart = context.watch<Menuitem>();
        final selectedStore = context.watch<Storeprovider>().selectedStore;
        final selectedPayment =
            context.watch<Paymethprovider>().selectedMethods;
        return Scaffold(
          appBar: AppBar(elevation: 0),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.store_mall_directory_outlined),
                      SizedBox(width: 10),
                      Text(
                        'Pick up Store Detail',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    selectedStore!.name,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    selectedStore.address,
                    style: GoogleFonts.montserrat(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.list_alt_rounded),
                      SizedBox(width: 10),
                      Text(
                        'Detail Order',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,

                    itemCount: userCart.cart.length,
                    itemBuilder: (context, index) {
                      final orderCartList = userCart.cart[index];
                      return Ordertile(cart: orderCartList);
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.note_alt_outlined),
                      SizedBox(width: 10),
                      Text(
                        'Note for Restaurant',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    menuItem.restaurantNote.isEmpty
                        ? "Note : -"
                        : "Note : ${menuItem.restaurantNote}",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.wallet_rounded),
                      SizedBox(width: 10),
                      Text(
                        'Payment',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Containernopad(
                    widget: ListTile(
                      leading: Image.asset(
                        selectedPayment!.imagePath,
                        scale: 15,
                      ),
                      title: Text(
                        "Transfer Bank ${selectedPayment.name}",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.blinds_closed_outlined),
                          SizedBox(width: 10),
                          Row(
                            children: [
                              Text(
                                'Total Bills',
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' (Inc Fee)',
                                style: GoogleFonts.montserrat(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
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

                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(12),
            child: SliderButton(
              action: () async {
                /// Ketika geser sukses, tampilkan pop-up berhasil
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text('Transaksi Berhasil!'),
                        content: Text('Pembayaran Anda telah dikonfirmasi.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                );
              },
              width: double.infinity,
              shimmer: true, // Efek menyala
              buttonSize: 60, // Ukuran tombol slider
              alignLabel: Alignment.center,
              backgroundColor: Colors.blue,
              highlightedColor: Colors.blue.shade800,
              baseColor: Colors.white,
              buttonColor: Colors.white,
              label: Text(
                "Slide To Pay",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: Center(
                child: Icon(Icons.arrow_forward, color: Colors.blue, size: 30),
              ),
            ),
          ),
        );
      },
    );
  }
}
