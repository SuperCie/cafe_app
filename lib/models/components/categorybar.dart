import 'package:coffee_app/data/item.dart';
import 'package:coffee_app/models/components/categorybaritem.dart';
import 'package:flutter/material.dart';

class Categorybar extends StatelessWidget {
  const Categorybar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:
            categoryItem.values.map((categoryItem) {
              return Categorybaritem(category: categoryItem);
            }).toList(),
      ),
    );
  }
}
