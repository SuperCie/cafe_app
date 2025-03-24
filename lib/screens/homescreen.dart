import 'package:coffee_app/data/cart.dart';
import 'package:coffee_app/data/database/userprovider.dart';
import 'package:coffee_app/data/menuitem.dart';
import 'package:coffee_app/data/storeprovider.dart';
import 'package:coffee_app/models/components/sliverappbarmodel.dart';
import 'package:coffee_app/models/components/slivercategorybar.dart';
import 'package:coffee_app/models/components/tileitem.dart';
import 'package:coffee_app/screens/cartscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    Provider.of<Userprovider>(context, listen: false).fetchUserData();
    Provider.of<Menuitem>(context, listen: false).fetchMenuFromFirestore();
    Provider.of<Menuitem>(
      context,
      listen: false,
    ).fetchCartFromFirestore(userId, context);
  }

  @override
  Widget build(BuildContext context) {
    final selectedStore = Provider.of<Storeprovider>(context).selectedStore;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Consumer<Userprovider>(
        builder: (context, userProvider, child) {
          if (userProvider.userData == null) {
            // Tampilkan loading indicator jika data belum diambil
            return Center(child: CircularProgressIndicator());
          }

          return CustomScrollView(
            slivers: [
              Sliverappbarmodel(),
              SliverPersistentHeader(
                delegate: Slivercategorybar(),
                floating: true,
              ),
              Consumer<Menuitem>(
                builder: (context, menuItem, child) {
                  final items = menuItem.selectedItem;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Tileitem(items: items[index]);
                    }, childCount: items.length),
                  );
                },
              ),
            ],
          );
        },
      ),

      floatingActionButton: StreamBuilder<List<Cart>>(
        stream: Provider.of<Menuitem>(context).getCartStream(userId),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return FloatingActionButton(
              backgroundColor: Colors.green.shade800,
              child: Icon(Icons.shopping_bag_rounded, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => Cartscreen(selectedStore: selectedStore),
                  ),
                );
              },
            );
          }
          return const SizedBox(); // Return widget kosong
        },
      ),
    );
  }
}
