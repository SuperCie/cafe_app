import 'package:flutter/material.dart';

class Myformfield extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  void Function()? ontap;
  final String? Function(String?)? validator;
  final Function(String)? onchanged;
  final bool? readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? labelStyle;
  final bool obscureText;
  Myformfield({
    super.key,
    this.labelStyle,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly,
    required this.controller,
    required this.text,
    this.validator,
    this.ontap,
    this.onchanged,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 1.5,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          fillColor: Theme.of(context).colorScheme.primary,
          labelText: text,
          filled: true,
          prefixIcon: prefixIcon,
        ),
        validator: validator,
        onTap: ontap,
        onChanged: onchanged,
      ),
    );
  }
}
