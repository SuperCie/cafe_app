import 'package:coffee_app/data/menuitem.dart';
import 'package:coffee_app/data/storeprovider.dart';
import 'package:coffee_app/models/components/sliverappbarmodel.dart';
import 'package:coffee_app/models/components/slivercategorybar.dart';
import 'package:coffee_app/models/components/tileitem.dart';
import 'package:coffee_app/screens/cartscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    final userCart = context.watch<Menuitem>();
    final selectedStore = Provider.of<Storeprovider>(context).selectedStore;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          Sliverappbarmodel(),
          SliverPersistentHeader(delegate: Slivercategorybar(), floating: true),
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
      ),

      floatingActionButton:
          userCart.cart.isNotEmpty
              ? FloatingActionButton(
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
              )
              : null,
    );
  }
}
