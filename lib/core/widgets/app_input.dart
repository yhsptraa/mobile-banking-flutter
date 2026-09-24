import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    super.key,
    required this.label,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.keyboardType,
  });

  final String label;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      autocorrect: !isPassword,
      enableSuggestions: !isPassword,
      validator: validator,
      decoration: InputDecoration(labelText: label),
    );
  }
}
