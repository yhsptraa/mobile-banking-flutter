import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../widgets/transfer_details.dart';

class TransferConfirmationScreen extends ConsumerStatefulWidget {
  final String recipientName;
  final String bankName;
  final String accountNumber;
  final double amount;
  final double adminFee;
  final String message;
  final String status;

  const TransferConfirmationScreen({
    super.key,
    required this.recipientName,
    this.bankName = 'BCA',
    required this.accountNumber,
    required this.amount,
    this.adminFee = 0.0,
    this.message = 'Transfer m-BCA',
    this.status = 'TRANSAKSI BERHASIL',
  });
  factory TransferConfirmationScreen.fromMap(Map<String, String> transferData) {
    return TransferConfirmationScreen(
      recipientName: transferData['name'] ?? '',
      accountNumber: transferData['accountNumber'] ?? '',
      amount: double.tryParse(transferData['amount'] ?? '0') ?? 0.0,
    );
  }

  @override
  ConsumerState<TransferConfirmationScreen> createState() =>
      _TransferConfirmationScreenState();
}

class _TransferConfirmationScreenState
    extends ConsumerState<TransferConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Bukti Transaksi',
          style: TextStyle(color: AppColors.textWhite, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.textWhite),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TransferDetails(
              recipientName: widget.recipientName,
              bankName: widget.bankName,
              accountNumber: widget.accountNumber,
              amount: widget.amount,
              adminFee: widget.adminFee,
              message: widget.message,
              status: widget.status,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Kirim',
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}