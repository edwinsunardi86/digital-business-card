import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFormFieldVarian1 extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final String? labelText;
  final Icon? prefixIcon;
  final String? Function(String?)? validator;
  const TextFormFieldVarian1(
      {super.key,
      this.controller,
      this.obscureText,
      this.labelText,
      this.prefixIcon,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText!,
      validator: validator,
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
