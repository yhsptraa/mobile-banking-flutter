import '../../../core/widgets/scrollable_form.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../widgets/confirm_button_rekening.dart';
import '../widgets/input_rekening.dart';

class InputRekeningScreen extends ConsumerStatefulWidget {
  const InputRekeningScreen({super.key});
  @override
  ConsumerState<InputRekeningScreen> createState() =>
      _InputRekeningScreenState();
}

class _InputRekeningScreenState extends ConsumerState<InputRekeningScreen> {
  final _nameController = TextEditingController();
  final _accountController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Tambahkan rekening baru',
          style: TextStyle(color: AppColors.textWhite),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
      ),
      body: ScrollableForm(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Informasi rekening baru',
                style: AppTextStyles.heading3,
              ),
              const SizedBox(height: 16),
              InputRekening(
                nameController: _nameController,
                accountController: _accountController,
              ),
              const Spacer(),
              ConfirmButtonRekening(
                nameController: _nameController,
                accountController: _accountController,
                onConfirmed: (data) {
                  Navigator.pop(context, data);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
