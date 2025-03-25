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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Userprovider>(context, listen: false).fetchUserData();
  }

  void slidePay(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final selectedStore =
        Provider.of<Storeprovider>(context, listen: false).selectedStore;
    final method =
        Provider.of<Paymethprovider>(context, listen: false).selectedMethods;
    try {
      //ambil data dari database
      DocumentSnapshot userData =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .get();

      String userName = userData['name'];

      Provider.of<Menuitem>(context, listen: false).checkOutOrder(
        uid: userData.id,
        userName: userName,
        storeName: selectedStore!.name,
        paymentMethod: method!.name,
      );

      // hapus
      Provider.of<Storeprovider>(context, listen: false).clearStore();
      Provider.of<Paymethprovider>(context, listen: false).clearMethod();

      await Future.delayed(Duration(milliseconds: 300));

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder:
              (context, animation, secondaryAnimation) => Thankscreen(),
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    } catch (e) {
      displayError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Menuitem>(
      builder: (context, menuItem, child) {
        // get cart data
        final userCart = context.watch<Menuitem>();
        final selectedStore = context.watch<Storeprovider>().selectedStore;
        final selectedPayment =
            context.watch<Paymethprovider>().selectedMethods;
        final userData =
            Provider.of<Userprovider>(context, listen: false).userData;
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
                    "-> ${selectedStore!.name}",
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
                  SizedBox(height: 20),
                  SlideAction(
                    innerColor: Theme.of(context).colorScheme.onTertiary,
                    outerColor: Colors.blue,
                    sliderButtonIcon: Icon(Icons.arrow_forward_ios_rounded),
                    text: 'Slide to Pay',
                    sliderRotate: false,
                    onSubmit: () {
                      slidePay(context);
                    },
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
