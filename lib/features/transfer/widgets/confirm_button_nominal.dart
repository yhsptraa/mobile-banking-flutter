import 'package:flutter/material.dart';
import '../../../core/widgets/app_button.dart';

class ConfirmButtonNominal extends StatelessWidget {
  final TextEditingController nominalController;
  final Map<String, String>? selectedAccount;
  final Function(Map<String, String>) onConfirmed;
  const ConfirmButtonNominal({
    super.key,
    required this.nominalController,
    required this.selectedAccount,
    required this.onConfirmed,
  });
  
  void _handlePress(BuildContext context) {
    final nominalText = nominalController.text.trim();
    final nominal = int.tryParse(nominalText) ?? 0;
    if (nominalText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nominal transfer wajib diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (nominal < 10000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nominal transfer minimal Rp 10.000'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    final transferData = {
      'name': selectedAccount?['name'] ?? '',
      'accountNumber': selectedAccount?['accountNumber'] ?? '',
      'amount': nominalText,
    };
    onConfirmed(transferData);
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