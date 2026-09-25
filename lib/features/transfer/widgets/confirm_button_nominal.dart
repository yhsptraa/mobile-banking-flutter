import 'package:flutter/material.dart';
import '../../../core/widgets/app_button.dart';

class ConfirmButtonNominal extends StatelessWidget {
  final TextEditingController nominalController;
  final VoidCallback? onConfirmed;

  const ConfirmButtonNominal({
    super.key, 
    required this.nominalController, 
    required this.onConfirmed
  });

  void _handlePress (BuildContext context) {
    final nominal = nominalController.text;
    if (nominal.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Nominal transfer wajib diisi'
          )
        )
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: AppButton(
        label: 'Lanjutkan', 
        onPressed: () => _handlePress(context),
      ),
    );
  }
}