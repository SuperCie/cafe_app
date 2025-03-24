import 'package:coffee_app/data/item.dart';
import 'package:coffee_app/data/menuitem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Itempage extends StatefulWidget {
  final Item items;
  Itempage({super.key, required this.items,});

  @override
  State<Itempage> createState() => _ItempageState();
}

class _ItempageState extends State<Itempage> {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final ScrollController _scrollController = ScrollController();

  // Selected Addons by Category
  Map<Addoncategory, addonItem?> selectedAddons = {
    Addoncategory.Milk: null,
    Addoncategory.Special: null,
  };

  // Group Addons by Category
  Map<Addoncategory, List<addonItem>> groupAddonsByCategory(
    List<addonItem> addons,
  ) {
    Map<Addoncategory, List<addonItem>> groupedAddons = {};
    for (var addon in addons) {
      if (!groupedAddons.containsKey(addon.category)) {
        groupedAddons[addon.category] = [];
      }
      groupedAddons[addon.category]!.add(addon);
    }
    return groupedAddons;
  }

  // Build Addon List with Category Headers
  List<Widget> buildAddonList(List<addonItem> addons) {
    Map<Addoncategory, List<addonItem>> groupedAddons = groupAddonsByCategory(
      addons,
    );
    List<Widget> widgetList = [];

    groupedAddons.forEach((category, addonList) {
      // Category Header
      widgetList.add(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.primary,
          child: Text(
            '${category.toString().split('.').last} Additional (Optional, maksimal 1)', // Get category name
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

      // Addon Items
      for (var addon in addonList) {
        widgetList.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CheckboxListTile(
              value: selectedAddons[addon.category] == addon,
              title: Text(
                addon.name,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
              subtitle: Text(
                addon.formatedAddon,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selectedAddons[addon.category] = addon;
                  } else {
                    selectedAddons[addon.category] = null;
                  }
                });
              },
              activeColor: Colors.green.shade800,
              checkColor: Colors.white,
            ),
          ),
        );
      }
    });

    return widgetList;
  }

  @override
  void initState() {
    super.initState();
    Provider.of<Menuitem>(context, listen: false).fetchMenuFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    void addCartItem(Item item, Map<Addoncategory, addonItem?> selectedAddons) {
      Provider.of<Menuitem>(context, listen: false);
      Navigator.pop(context);

      List<addonItem> currentlySelected = [];
      selectedAddons.forEach((category, addon) {
        if (addon != null) {
          currentlySelected.add(addon);
        }
      });

      context.read<Menuitem>().addCartItem(item, currentlySelected, userId);
    }

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Hero(
                  tag: widget.items.imagePath,
                  child: Image.asset(
                    widget.items.imagePath,
                    width: double.infinity,
                    height: 320,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.items.name,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.items.formattedPrice,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1.0),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    widget.items.description,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Divider(thickness: 1.0),
                ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: buildAddonList(widget.items.availableAddon),
                ),

                SizedBox(height: 100),
              ],
            ),
          ),
          bottomSheet: BottomAppBar(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () => addCartItem(widget.items, selectedAddons),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(width: 1.5),
                  color: Colors.green.shade800,
                ),
                child: Center(
                  child: Text(
                    'Add to Cart',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
        ),
      ],
    );
  }
}
