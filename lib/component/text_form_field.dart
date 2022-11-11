import 'package:flutter/material.dart';

class TextFormFieldVarian1 extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final String? labelText;
  final Icon? prefixIcon;
  final String? Function(String?)? validator;
  final bool? autofocus;
  final FocusNode? focusNode;
  const TextFormFieldVarian1(
      {super.key,
      this.controller,
      this.obscureText,
      this.labelText,
      this.prefixIcon,
      this.validator,
      this.autofocus,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText!,
      validator: validator,
      autofocus: autofocus ?? false,
      focusNode: focusNode,
      decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 0.5, color: Colors.grey)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 0.5, color: Colors.red)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 0.5, color: Colors.blue))),
    );
  }
}
