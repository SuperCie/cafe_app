import 'package:coffee_app/data/item.dart';
import 'package:coffee_app/data/menuitem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Categorybaritem extends StatelessWidget {
  final categoryItem category;
  const Categorybaritem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final menuItem = Provider.of<Menuitem>(context);

    bool isSelected = menuItem.selectedCategory == category;

    return GestureDetector(
      onTap: () {
        Provider.of<Menuitem>(context, listen: false).setCategory(category);
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1.5,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          child: Center(
            child: Text(
              category.toString().split('.').last,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
