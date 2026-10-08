import 'package:flutter/material.dart';

class WithdrawalConfirmButton extends StatelessWidget {
  const WithdrawalConfirmButton({
    super.key,
    required this.enabled,
    required this.onPressed,
  });

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        child: const Text('Continue'),
      ),
    );
  }
}

