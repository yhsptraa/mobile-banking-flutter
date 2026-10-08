import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class TransferDetails extends ConsumerWidget {
  final String recipientName;
  final String bankName;
  final String accountNumber;
  final double amount;
  final double adminFee;
  final String message;
  final String status;
  const TransferDetails({
    super.key,
    required this.recipientName,
    required this.bankName,
    required this.accountNumber,
    required this.amount,
    required this.adminFee,
    required this.message,
    required this.status,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalAmount = amount + adminFee;
    return Card(
      elevation: 1,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: AppColors.success,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(color: AppColors.border),
            _buildDetailRow('Bank Tujuan', bankName),
            _buildDetailRow('Rekening Tujuan', accountNumber),
            _buildDetailRow('Nama Penerima', recipientName),
            _buildDetailRow('Catatan/Berita', message),
            const Divider(color: AppColors.border),
            _buildDetailRow('Nominal Transfer', 'Rp ${amount.toStringAsFixed(0)}'),
            _buildDetailRow('Biaya Admin', 'Rp ${adminFee.toStringAsFixed(0)}'),
            const Divider(color: AppColors.border),
            _buildDetailRow(
              'Total Transaksi',
              'Rp ${totalAmount.toStringAsFixed(0)}',
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall,
          ),
          Text(
            value,
            style: isBold
                ? AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)
                : AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}