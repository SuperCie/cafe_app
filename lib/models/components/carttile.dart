import 'package:coffee_app/data/cart.dart';
import 'package:coffee_app/data/menuitem.dart';
import 'package:coffee_app/models/components/quantitymodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class Carttile extends StatefulWidget {
  final Cart cart;

  Carttile({super.key, required this.cart});

  @override
  State<Carttile> createState() => _CarttileState();
}

class _CarttileState extends State<Carttile> {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Menuitem>(
      context,
      listen: false,
    ).fetchCartFromFirestore(userId, context);
  }

  @override
  Widget build(BuildContext context) {
    void openSlidable(BuildContext context) {
      Future.delayed(Duration.zero, () {
        final slidable = Slidable.of(context);
        if (slidable != null) {
          slidable.openEndActionPane();
        }
      });
    }

    return Consumer<Menuitem>(
      builder:
          (context, menuItem, child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    backgroundColor: Colors.red.shade800,
                    borderRadius: BorderRadius.circular(25),
                    onPressed: (context) {
                      menuItem.deleteCart(widget.cart, context, userId);
                    },
                    icon: Icons.delete,
                  ),
                ],
              ),
              child: Builder(
                builder: (slidableContext) {
                  return Container(
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
                                    tag: widget.cart.item.imagePath,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.asset(
                                        widget.cart.item.imagePath,
                                        width: 70,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.cart.item.name,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      if (widget.cart.selectedAddon.isNotEmpty)
                                        Row(
                                          children:
                                              widget.cart.selectedAddon
                                                  .map(
                                                    (addon) => SizedBox(
                                                      width: 70,
                                                      child: Text(
                                                        addon.name + ' ',
                                                        style:
                                                            GoogleFonts.montserrat(
                                                              fontSize: 14,
                                                            ),
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                        ),
                                      SizedBox(height: 10),
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
                                  // quantity
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                TextButton(
                                  onPressed:
                                      () => openSlidable(slidableContext),
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
                                  quantity: widget.cart.quantity,
                                  item: widget.cart.item,
                                  onDecrement: () {
                                    menuItem.deleteCart(
                                      widget.cart,
                                      context,
                                      userId,
                                    );
                                    if (menuItem.cart.isEmpty) {
                                      menuItem.clearInputNote();
                                    }
                                  },
                                  onIncrement: () {
                                    menuItem.addCartItem(
                                      widget.cart.item,
                                      widget.cart.selectedAddon,
                                      userId,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
    );
  }
}
