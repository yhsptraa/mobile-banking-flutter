import 'package:flutter/material.dart';
import '../../../core/widgets/app_button.dart';

class ConfirmButtonRekening extends StatelessWidget {
  final VoidCallback onPressed;
  const ConfirmButtonRekening({
    super.key, required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: AppButton(
        label: 'Simpan rekening', 
        onPressed: () {
          // TODO: Peringatan konfirmasi simpan rekening
        },
      ),
    );
  }
}