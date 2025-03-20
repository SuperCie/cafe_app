import 'package:flutter/material.dart';

class Myformfield extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  void Function()? ontap;
  final String? Function(String?)? validator;
 final Function(String)? onchanged;
  Myformfield({
    super.key,
    required this.controller,
    required this.text,
    required this.validator,
    required this.ontap,
    this.onchanged
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 1.5,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          labelText: text,
          filled: true,
        ),
        validator: validator,
        onTap: ontap,
        onChanged: onchanged,
      ),
    );
  }
}
