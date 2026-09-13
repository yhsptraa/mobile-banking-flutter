import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    super.key,
    required this.label,
    this.isPassword = false,
    this.validator,
  });

  final String label;
  final bool isPassword;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      autocorrect: !isPassword,
      enableSuggestions: !isPassword,
      validator: validator,
      decoration: InputDecoration(labelText: label),
    );
  }
}
