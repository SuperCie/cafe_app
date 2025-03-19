import 'package:coffee_app/data/item.dart';
import 'package:flutter/material.dart';

class Quantitymodel extends StatelessWidget {
  final int quantity;
  final Item item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  const Quantitymodel({
    super.key,
    required this.quantity,
    required this.item,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // decrease button
        GestureDetector(
          onTap: onDecrement,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red.shade800),
            ),
            child: Icon(Icons.remove, size: 20, color: Colors.red.shade800),
          ),
        ),
        // quantity
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(child: Text(quantity.toString())),
        ),
        // increase button
        GestureDetector(
          onTap: onIncrement,
          child: Container(
            color: Colors.red.shade800,
            child: Icon(Icons.add, size: 20, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
