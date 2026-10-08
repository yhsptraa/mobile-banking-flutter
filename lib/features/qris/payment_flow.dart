import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/transaction.dart';
import '../../services/banking_service.dart';
import '../../state/session_controller.dart';
import 'qris.dart';

Future<void> scanAndPay(BuildContext context, WidgetRef ref) async {
  final qrData = await Navigator.push<String>(
    context,
    MaterialPageRoute(builder: (_) => const QrisScreen()),
  );
  if (!context.mounted || qrData == null) return;
  await demoPayment(context, ref, title: 'Pembayaran QRIS', qrData: qrData);
}

Future<void> demoPayment(
  BuildContext context,
  WidgetRef ref, {
  required String title,
  bool topUp = false,
  String? qrData,
}) async {
  final accountId = ref.read(sessionControllerProvider).accountId;
  if (accountId == null) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Silakan login kembali')));
    return;
  }
  final service = ref.read(bankingServiceProvider);
  final success = await showDialog<bool>(
    context: context,
    builder: (_) => _PaymentDialog(
      title: title,
      onSubmit: (amount) => topUp
          ? service.topUp(accountId: accountId, amount: amount)
          : service.spend(
              accountId: accountId,
              amount: amount,
              title: title,
              type: TransactionType.payment,
              qrData: qrData,
            ),
    ),
  );
  if (context.mounted && success == true) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$title berhasil (demo)')));
  }
}

class _PaymentDialog extends StatefulWidget {
  const _PaymentDialog({required this.title, required this.onSubmit});
  final String title;
  final Future<void> Function(int) onSubmit;
  @override
  State<_PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<_PaymentDialog> {
  final controller = TextEditingController();
  bool busy = false;
  String? error;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (busy) return;
    final amount = int.tryParse(controller.text);
    if (amount == null || amount <= 0) {
      setState(() => error = 'Masukkan nominal yang benar');
      return;
    }
    setState(() {
      busy = true;
      error = null;
    });
    try {
      await widget.onSubmit(amount);
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted)
        setState(
          () => error = e is StateError
              ? e.message
              : 'Transaksi gagal. Coba kembali.',
        );
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !busy,
    child: AlertDialog(
      title: Text('${widget.title} (demo)'),
      content: TextField(
        controller: controller,
        enabled: !busy,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: 'Nominal',
          prefixText: 'Rp ',
          errorText: error,
        ),
      ),
      actions: [
        TextButton(
          onPressed: busy ? null : () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: busy ? null : submit,
          child: Text(busy ? 'Memproses...' : 'Konfirmasi'),
        ),
      ],
    ),
  );
}
