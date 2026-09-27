import 'package:flutter/material.dart';
import 'transfer.dart';

class TransferConfirmationScreen extends StatelessWidget {
  final String recipientName;
  final String bankName;
  final String accountNumber;
  final double amount;
  final double adminFee;

  const TransferConfirmationScreen({
    Key? key,
    required this.recipientName,
    required this.bankName,
    required this.accountNumber,
    required this.amount,
    required this.adminFee,
  });

  @override
  Widget build(BuildContext context) {
    final total = amount + adminFee;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Konfirmasi Transfer',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(color: const Color(0xFF003399)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TRANSFER KE',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recipientName,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF003399)),
                    ),
                    Text(
                      '$bankName - $accountNumber',
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const Divider(height: 30),
                    _buildDetailRow(
                        'Nominal Transfer', 'Rp ${amount.toStringAsFixed(0)}'),
                    const SizedBox(height: 8),
                    _buildDetailRow(
                        'Biaya Admin', 'Rp ${adminFee.toStringAsFixed(0)}'),
                    const Divider(height: 30),
                    _buildDetailRow(
                        'Total Transaksi', 'Rp ${total.toStringAsFixed(0)}',
                        isTotal: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF003399),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransferScreen(
                        transactionId: '2026091812345678',
                        transactionDate: '18 Sep 2026, 20:15',
                        recipientName: recipientName,
                        bankName: bankName,
                        accountNumber: accountNumber,
                        amount: amount,
                        adminFee: adminFee,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'LANJUTKAN',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: isTotal ? Colors.black : Colors.grey[700],
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? const Color(0xFF003399) : Colors.black,
          ),
        ),
      ],
    );
  }
}
