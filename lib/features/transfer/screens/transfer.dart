import 'package:flutter/material.dart';

class TransferScreen extends StatelessWidget {
  final String transactionId;
  final String transactionDate;
  final String recipientName;
  final String bankName;
  final String accountNumber;
  final double amount;
  final double adminFee;

  const TransferScreen({
    Key? key,
    required this.transactionId,
    required this.transactionDate,
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
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text(
          'Bukti Transaksi',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF003399),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 64,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'TRANSAKSI BERHASIL',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Rp ${total.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003399),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(thickness: 1),
                    const SizedBox(height: 12),
                    _buildReceiptRow('No. Referensi', transactionId),
                    _buildReceiptRow('Tanggal & Waktu', transactionDate),
                    const Divider(height: 24, thickness: 0.8),
                    _buildReceiptRow('Bank Tujuan', bankName),
                    _buildReceiptRow('Rekening Tujuan', accountNumber),
                    _buildReceiptRow('Nama Penerima', recipientName),
                    const Divider(height: 24, thickness: 0.8),
                    _buildReceiptRow(
                        'Nominal', 'Rp ${amount.toStringAsFixed(0)}'),
                    _buildReceiptRow(
                        'Biaya Admin', 'Rp ${adminFee.toStringAsFixed(0)}'),
                    _buildReceiptRow('Total', 'Rp ${total.toStringAsFixed(0)}',
                        isBold: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: Color(0xFF003399)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Bukti transaksi berhasil disimpan!')),
                      );
                    },
                    icon: const Icon(Icons.share, color: Color(0xFF003399)),
                    label: const Text(
                      'BAGIKAN',
                      style: TextStyle(
                        color: Color(0xFF003399),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      primary: const Color(0xFF003399),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: const Text(
                      'SELESAI',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: isBold ? const Color(0xFF003399) : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
