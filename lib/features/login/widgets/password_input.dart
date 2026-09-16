import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key, this.validator});

  final String? Function(String?)? validator;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isHidden,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: IconButton(
          tooltip: _isHidden ? 'Tampilkan password' : 'sembunyikan password',
          onPressed: () {
            setState(() {
              _isHidden = !_isHidden;
            });
          }, 
          icon: Icon(_isHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined)
          )
      ),
    );
  }
}