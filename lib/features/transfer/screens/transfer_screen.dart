import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../transfer/screens/input_nominal_screen.dart';
import '../../transfer/screens/input_rekening_screen.dart';

class TransferScreen extends ConsumerStatefulWidget {
  const TransferScreen({super.key});
  @override
  ConsumerState<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferScreen> {
  final List<Map<String, String>> _savedAccounts = [];

  void _navigateToInputRekening() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InputRekeningScreen(),
      ),
    );
    if (result != null) {
      setState(() {
        _savedAccounts.add(result);
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Rekening berhasil disimpan'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Transfer', style: TextStyle(color: AppColors.textWhite)),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const Text(
            'Pilih layanan transfer',
            style: AppTextStyles.heading3,
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 1,
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.border),
            ),
            child: ListTile(
              title: const Text('Transfer rekening baru', style: AppTextStyles.bodyLarge),
              trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              onTap: _navigateToInputRekening,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 1,
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.border),
            ),
            child: ListTile(
              title: const Text('Transfer rekening lama', style: AppTextStyles.bodyLarge),
              subtitle: Text(
                '${_savedAccounts.length} rekening tersimpan',
                style: AppTextStyles.bodySmall,
              ),
              trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              onTap: () {
                if (_savedAccounts.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InputNominalScreen(
                        dataAccounts: _savedAccounts,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Belum ada rekening tersimpan, tambahkan rekening baru terlebih dahulu',
                      ),
                      backgroundColor: AppColors.warning,
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: AppButton(
              label: 'Bantuan',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: AppColors.surface,
                    title: const Text('Petunjuk layanan transfer', style: AppTextStyles.heading3),
                    content: const Text(
                      'Transfer rekening baru: Anda dapat memasukkan nomor rekening yang belum pernah terdaftar sebelumnya.\n\n'
                      'Transfer rekening lama: Anda dapat mentransfer ke nomor rekening yang pernah terdaftar sebelumnya.',
                      style: AppTextStyles.bodyMedium,
                    ),
                    actions: [
                      AppButton(
                        label: 'Mengerti',
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}