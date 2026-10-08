import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';

class ConfirmButtonRekening extends ConsumerWidget {
  final TextEditingController nameController;
  final TextEditingController accountController;
  final Function(Map<String, String>) onConfirmed;

  const ConfirmButtonRekening({
    super.key,
    required this.nameController,
    required this.accountController,
    required this.onConfirmed,
  });

  void _handlePress(BuildContext context) {
    final name = nameController.text;
    final accountNumber = accountController.text;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama pemilik rekening wajib diisi'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    if (accountNumber.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nomor rekening minimal 10 digit'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Konfirmasi simpan rekening', style: AppTextStyles.heading3),
        content: const Text('Pastikan data rekening sudah benar', style: AppTextStyles.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textWhite,
            ),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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