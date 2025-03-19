import 'package:flutter/material.dart';

class Containernopad extends StatelessWidget {
  Widget? widget;
  Containernopad({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Theme.of(context).colorScheme.secondary,
        ),
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: widget,
    );
  }
}
