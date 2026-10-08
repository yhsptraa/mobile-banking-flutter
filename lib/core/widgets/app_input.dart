import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    super.key,
    required this.label,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.keyboardType,
    this.enabled = true, // Tambahkan parameter enabled
  });

  final String label;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool enabled; // Deklarasikan variabel enabled

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      autocorrect: !isPassword,
      enableSuggestions: !isPassword,
      validator: validator,
      keyboardType: keyboardType, // Tambahkan ini agar format keyboard sesuai
      enabled: enabled, // Terapkan parameter enabled
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}