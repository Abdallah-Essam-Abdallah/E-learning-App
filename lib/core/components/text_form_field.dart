import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.obscureText,
    required this.keyboardType,
    required this.controller,
    this.validator,
    this.onChanged,
  });

  final String hintText;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //  onTapOutside: (event) => FocusScope.of(context).unfocus(),
      keyboardType: keyboardType,
      controller: controller,

      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          fillColor: Colors.black),
    );
  }
}
