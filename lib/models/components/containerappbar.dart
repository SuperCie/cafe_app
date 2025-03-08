import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Containerappbar extends StatelessWidget {
  void Function()? ontap;
  Widget? widget;
  Containerappbar({super.key, required this.widget, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(color: Colors.transparent, child: widget),
    );
  }
}
