import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/transfer_details.dart';
import '../widgets/button_navigate_home.dart';

class TransferConfirmationScreen extends ConsumerStatefulWidget {
  final String recipientName;
  final String bankName;
  final String accountNumber;
  final double amount;
  final double adminFee;
  final String message;
  final String status;

  const TransferConfirmationScreen({
    Key? key,
    required this.recipientName,
    required this.bankName,
    required this.accountNumber,
    required this.amount,
    required this.adminFee,
    this.message = 'Transfer m-BCA',
    this.status = 'TRANSAKSI BERHASIL',
  }) : super(key: key);

  @override
  ConsumerState<TransferConfirmationScreen> createState() => _TransferConfirmationScreenState();
}

class _TransferConfirmationScreenState extends ConsumerState<TransferConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Bukti Transaksi',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF003399),
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
            ButtonNavigateHome(
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