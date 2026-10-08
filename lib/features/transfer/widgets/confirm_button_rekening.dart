import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../data/repositories/account_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../state/session_controller.dart';

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

  Future<void> _handlePress(BuildContext context, WidgetRef ref) async {
    final name = nameController.text.trim();
    final accountNumber = accountController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama pemilik rekening wajib diisi'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    if (!RegExp(r'^\d{10}$').hasMatch(accountNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nomor rekening harus 10 digit'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    final accountRepository = ref.read(accountRepositoryProvider);
    final userRepository = ref.read(userRepositoryProvider);
    final ownAccountId = ref.read(sessionControllerProvider).accountId;
    try {
      final account = await accountRepository.findByAccountNumber(
        accountNumber,
      );
      if (!context.mounted) return;
      if (account == null || account.id == ownAccountId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              account == null
                  ? 'Rekening tujuan tidak ditemukan'
                  : 'Pilih rekening pengguna lain',
            ),
          ),
        );
        return;
      }
      final recipient = await userRepository.getUserById(account.userId);
      if (!context.mounted || recipient == null) return;
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text(
            'Konfirmasi simpan rekening',
            style: AppTextStyles.heading3,
          ),
          content: const Text(
            'Pastikan data rekening sudah benar',
            style: AppTextStyles.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Batal',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textWhite,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                onConfirmed({
                  'name': recipient.fullName,
                  'accountNumber': accountNumber,
                });
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      );
    } catch (_) {
      if (context.mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memeriksa rekening')),
        );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: AppButton(
        label: 'Simpan rekening',
        onPressed: () => _handlePress(context, ref),
      ),
    );
  }
}
