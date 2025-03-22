import 'package:flutter/material.dart';

class Googlebutton extends StatelessWidget {
  void Function()? ontap;
  Googlebutton({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.onTertiary,
          ),
          child: Image.asset(
            'assets/icons/icongoogle.png',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
