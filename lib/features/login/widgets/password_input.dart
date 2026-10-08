import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key, this.validator, this.controller});

  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isHidden,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: IconButton(
          tooltip: _isHidden ? 'Show password' : 'Hide password',
          onPressed: () {
            setState(() {
              _isHidden = !_isHidden;
            });
          },
          icon: Icon(
            _isHidden
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
      ),
    );
  }
}