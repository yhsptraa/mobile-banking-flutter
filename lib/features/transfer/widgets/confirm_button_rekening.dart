import 'package:flutter/material.dart';
import '../../../core/widgets/app_button.dart';

class ConfirmButtonRekening extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController accountController;
  final Function(Map<String, String>) onConfirmed;
  
  const ConfirmButtonRekening({
    super.key, 
    required this.nameController,
    required this.accountController,
    required this.onConfirmed,
  });

  void _handlePress (BuildContext context) {
    final name = nameController.text;
    final accountNumber = accountController.text;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Nama pemilik rekening wajib diisi'
          )
        )
      );
      return;
    } 
    if (accountNumber.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Nomor rekening minimal 10 digit'
          )
        )
      );
      return;
    }
    showDialog(
      context: context, 
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi simpan rekening'),
        content: const Text(
          'Pastikan data rekening sudah benar',
        ),
        actions: [
          AppButton(
            label: 'Batal', 
            onPressed: () => Navigator.pop(context)
          ),
          const Text(''),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              onConfirmed({
                'name': name,
                'accountNumber': accountNumber,
              });
            }, 
            child: const Text('Simpan'),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: AppButton(
        label: 'Simpan rekening', 
        onPressed: () => _handlePress(context),
      ),
    );
  }
}