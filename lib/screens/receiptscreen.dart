import 'package:flutter/material.dart';

class Receiptscreen extends StatelessWidget {
  const Receiptscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [Text('Order ID : ')]),
      ),
    );
  }
}
