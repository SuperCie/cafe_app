import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final Widget child;
  void Function()? ontap;
   Mybutton({super.key, required this.child, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onTertiaryContainer,

            borderRadius: BorderRadius.circular(30),
            border: Border.all(width: 1.0),
          ),
          child: child,
        ),
      ),
    );
  }
}
