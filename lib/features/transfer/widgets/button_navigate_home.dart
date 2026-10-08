import 'package:flutter/material.dart';

class ButtonNavigateHome extends StatelessWidget {
  final VoidCallback? onPressed;

  const ButtonNavigateHome({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF003399),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed ?? () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: const Text(
          'SELESAI',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}