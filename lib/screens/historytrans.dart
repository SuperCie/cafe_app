import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/data/database/historyprovider.dart';
import 'package:coffee_app/data/database/orderhistory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Historytrans extends StatefulWidget {
  const Historytrans({super.key});

  @override
  State<Historytrans> createState() => _HistorytransState();
}

class _HistorytransState extends State<Historytrans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'History List',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Consumer<Historyprovider>(
        builder: (context, provider, child) {
          return StreamBuilder<List<Orderhistory>>(
            stream: provider.getOrderedHistoryFromFirestore(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              final orders = snapshot.data ?? [];

              if (orders.isEmpty) {
                return Center(child: Text('No transaction History'));
              }
              return ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final tileOrderHistory = orders[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(width: 1.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Text(
                                tileOrderHistory.storeName,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              title: Text(
                                '// ${tileOrderHistory.orderId}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Divider(thickness: 1.5),
                            Text(
                              'Ordered Items:',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ...tileOrderHistory.detailItem
                                .map((item) => _buildItemTile(item))
                                .toList(),
                            Divider(thickness: 1.5),
                            Text(
                              'Payment with ${tileOrderHistory.payment}',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  tileOrderHistory.total.toString() != null
                                      ? NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp',
                                        decimalDigits: 0,
                                      ).format(
                                        double.parse(
                                          tileOrderHistory.total.toString(),
                                        ),
                                      )
                                      : 'Rp0',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[800],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

Widget _buildItemTile(Map<String, dynamic> detailItem) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              Text(
                detailItem['itemName'],
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
              Text(
                "x ${detailItem['qty']}".toString(),
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            detailItem['price'].toString() != null
                ? NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp',
                  decimalDigits: 0,
                ).format(double.parse(detailItem['price'].toString()))
                : 'Rp0',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.red[800],
            ),
          ),
        ],
      ),
      if (detailItem['addons'] != null &&
          (detailItem['addons'] as List).isNotEmpty)
        Padding(
          padding: EdgeInsets.only(left: 16, top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var addon in detailItem['addons'])
                Text(
                  "• ${addon['addonName']} (+${NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(double.parse(addon['addonPrice'].toString()))})",
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
            ],
          ),
        ),
    ],
  );
}
