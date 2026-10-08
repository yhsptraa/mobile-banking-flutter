import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../widgets/confirm_button_nominal.dart';
import '../widgets/input_nominal.dart';
import '../widgets/template_nominal.dart';
import 'transfer_confirmation_screen.dart';

class InputNominalScreen extends ConsumerStatefulWidget {
  final List<Map<String, String>> dataAccounts;
  final Map<String, String>? initialAccount;

  const InputNominalScreen({
    super.key,
    required this.dataAccounts,
    this.initialAccount,
  });
  @override
  ConsumerState<InputNominalScreen> createState() => _InputNominalScreenState();
}

class _InputNominalScreenState extends ConsumerState<InputNominalScreen> {
  final _nominalController = TextEditingController();
  Map<String, String>? _selectedAccount;
  @override
  void initState() {
    super.initState();
    _selectedAccount = widget.initialAccount ??
        (widget.dataAccounts.isNotEmpty ? widget.dataAccounts.first : null);
  }
  @override
  void dispose() {
    _nominalController.dispose();
    super.dispose();
  }
  void _selectTemplateNominal(int value) {
    setState(() {
      _nominalController.text = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Input nominal transfer', style: TextStyle(color: AppColors.textWhite)),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih rekening tujuan',
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<Map<String, String>>(
              value: _selectedAccount,
              dropdownColor: AppColors.surface,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
              items: widget.dataAccounts.map((account) {
                return DropdownMenuItem<Map<String, String>>(
                  value: account,
                  child: Text(
                    '${account['name']} (${account['accountNumber']})',
                    style: AppTextStyles.bodyMedium,
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedAccount = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            InputNominal(
              nominalController: _nominalController,
            ),
            const SizedBox(height: 16),
            const Text(
              'Pilihan nominal transfer',
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: 8),
            TemplateNominal(
              onSelectedNominal: _selectTemplateNominal,
            ),
            const Spacer(),
            ConfirmButtonNominal(
              nominalController: _nominalController,
              selectedAccount: _selectedAccount,
              onConfirmed: (transferData) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransferConfirmationScreen.fromMap(transferData),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}