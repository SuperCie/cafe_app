import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/autentication/helper/displayerror.dart';
import 'package:coffee_app/data/database/userprovider.dart';
import 'package:coffee_app/data/menuitem.dart';
import 'package:coffee_app/data/paymethprovider.dart';
import 'package:coffee_app/data/storeprovider.dart';
import 'package:coffee_app/models/components/containernopad.dart';
import 'package:coffee_app/models/components/ordertile.dart';
import 'package:coffee_app/screens/thankscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';

class Orderscreen extends StatefulWidget {
  const Orderscreen({super.key});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  final user = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      Provider.of<Userprovider>(context, listen: false).fetchUserData();
      Provider.of<Menuitem>(
        context,
        listen: false,
      ).fetchCartFromFirestore(user, context);
    });
  }

  Future<void> slidePay(BuildContext context) async {
    final navigatorContext = Navigator.of(context).context;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => PopScope(
            canPop: false,
            child: Center(child: CircularProgressIndicator()),
          ),
    );
    try {
      await Provider.of<Menuitem>(
        context,
        listen: false,
      ).checkout(navigatorContext);
    } catch (e) {
      if (Navigator.of(navigatorContext).canPop()) {
        Navigator.of(navigatorContext).pop();
      }
      displayError(navigatorContext, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<Menuitem, Storeprovider, Paymethprovider, Userprovider>(
      builder: (
        context,
        menuItem,
        storeProvider,
        paymethProvider,
        userprovider,
        child,
      ) {
        // get cart data
        final userCart = menuItem.cart;
        final selectedStore = storeProvider.selectedStore;
        final selectedPayment = paymethProvider.selectedMethods;
        final userData = userprovider.userData;

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'Order Summary',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 10),
                      Text(
                        "${userData?['name']}".toUpperCase(),
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
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
                    "-> ${selectedStore?.name}",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    selectedStore?.address ?? 'Alamat tidak tersedia',
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

                    itemCount: userCart.length,
                    itemBuilder: (context, index) {
                      final orderCartList = userCart[index];
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
                        selectedPayment?.imagePath ?? 'Gambar tidak tersedia',
                        scale: 15,
                      ),
                      title: Text(
                        "Transfer Bank ${selectedPayment?.name}",
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
                  SizedBox(height: 20),
                  SlideAction(
                    innerColor: Theme.of(context).colorScheme.onTertiary,
                    outerColor: Colors.blue,
                    sliderButtonIcon: Icon(Icons.arrow_forward_ios_rounded),
                    text: 'Slide to Pay',
                    sliderRotate: false,
                    onSubmit: () => slidePay(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
