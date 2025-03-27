import 'package:coffee_app/data/menuitem.dart';
import 'package:coffee_app/data/paymethprovider.dart';
import 'package:coffee_app/data/paymeths.dart';
import 'package:coffee_app/data/store.dart';
import 'package:coffee_app/data/storeprovider.dart';
import 'package:coffee_app/models/components/carttile.dart';
import 'package:coffee_app/models/components/containermodel.dart';
import 'package:coffee_app/models/components/containernopad.dart';
import 'package:coffee_app/models/components/myformfield.dart';
import 'package:coffee_app/screens/orderscreen.dart';
import 'package:coffee_app/screens/paymetscreen.dart';
import 'package:coffee_app/screens/storescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Cartscreen extends StatefulWidget {
  final Store? selectedStore;
  final Paymeths? selectedMethods;
  const Cartscreen({Key? key, this.selectedStore, this.selectedMethods})
    : super(key: key);

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final reNoteController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final menuItem = Provider.of<Menuitem>(context, listen: false);
    reNoteController.text = menuItem.restaurantNote;
    Provider.of<Menuitem>(
      context,
      listen: false,
    ).fetchCartFromFirestore(userId, context);
  }

  //function
  void pickStore() async {
    final pickedStore = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Storescreen(),
      ), // Halaman pilih store
    );
    if (pickedStore is Store) {
      Provider.of<Storeprovider>(context, listen: false).setStore(pickedStore);
    }
  }

  void selectPaymentMethods() async {
    final selectedPayment = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Paymetscreen()),
    );

    if (selectedPayment is Paymeths) {
      Provider.of<Paymethprovider>(
        context,
        listen: false,
      ).setPaymentMethod(selectedPayment);
    }
  }

  void _validateAndNavigate(BuildContext context) {
    final storeProvider = Provider.of<Storeprovider>(context, listen: false);
    final payProvider = Provider.of<Paymethprovider>(context, listen: false);
    final menuItem = Provider.of<Menuitem>(context, listen: false);

    // Validasi apakah store dan payment method sudah dipilih
    if (storeProvider.selectedStore == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please select a store first!",
            style: GoogleFonts.montserrat(fontSize: 16),
          ),
          backgroundColor: Colors.red.shade800,
        ),
      );
      return;
    }

    if (payProvider.selectedMethods == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please select a payment method first!",
            style: GoogleFonts.montserrat(fontSize: 16),
          ),
          backgroundColor: Colors.red.shade800,
        ),
      );
      return;
    }
    Navigator.pop(context);
    // Navigasi ke Orderscreen dengan membawa data
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Orderscreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  Consumer<Storeprovider>(
                    builder: (context, storeProvider, child) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () => pickStore(),
                            leading: Icon(Icons.store_rounded),
                            title: Text(
                              storeProvider.selectedStore?.name ??
                                  "Choose Store",
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            trailing: Icon(
                              Icons.arrow_drop_down_circle_rounded,
                            ),
                          ),
                          Visibility(
                            visible: storeProvider.selectedStore != null,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                storeProvider.selectedStore?.address ?? "",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Your order will be ready in approximately 15-25 minutes.',
                      style: GoogleFonts.montserrat(fontSize: 16),
                      textAlign: TextAlign.center,
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
                        onPressed: () {
                          menuItem.deleteAllCart(context, userId);
                          menuItem.clearInputNote();
                        },
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
                  SlidableAutoCloseBehavior(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: userCart.length,
                      itemBuilder: (context, index) {
                        final cartItem = userCart[index];
                        return Carttile(cart: cartItem);
                      },
                    ),
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
                    onchanged: (value) {
                      menuItem.userInputRstNote(value);
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      TextButton(
                        onPressed: selectPaymentMethods,
                        child: Text(
                          'View All >',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Consumer<Paymethprovider>(
                    builder: (context, payProvider, child) {
                      return GestureDetector(
                        onTap: selectPaymentMethods,
                        child: Containernopad(
                          widget: ListTile(
                            leading: Image.asset(
                              payProvider.selectedMethods?.imagePath ??
                                  "assets/images/payment/nocardicon.png",
                              scale: 15,
                            ),
                            title: Text(
                              payProvider.selectedMethods != null
                                  ? "Transfer Bank ${payProvider.selectedMethods?.name}"
                                  : 'Choose Payment Methods',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
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
                                color: Colors.red.shade800,
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
                  onTap: () => _validateAndNavigate(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red.shade800,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                      ),
                    ),
                    padding: EdgeInsets.all(8),
                    width: 130,
                    height: double.infinity,
                    child: Center(
                      child: Text(
                        'Make Order',
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
