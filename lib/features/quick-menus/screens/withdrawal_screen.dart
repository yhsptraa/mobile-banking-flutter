import '../../../core/widgets/scrollable_form.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/banking_service.dart';
import '../../../state/session_controller.dart';
import '../../../data/models/transaction.dart';

import '../widgets/withdrawal_amount_selector.dart';
import '../widgets/withdrawal_confirm_button.dart';

class WithdrawalScreen extends ConsumerStatefulWidget {
  const WithdrawalScreen({super.key, this.onContinue});

  final ValueChanged<int>? onContinue;

  @override
  ConsumerState<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends ConsumerState<WithdrawalScreen> {
  final _amountController = TextEditingController();
  int? _selectedAmount;
  bool _busy = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _selectAmount(int amount) {
    setState(() {
      _selectedAmount = amount;
      _amountController.text = amount.toString();
    });
  }

  void _updateAmount(String value) {
    setState(() {
      _selectedAmount = int.tryParse(value);
    });
  }

  Future<void> _continueWithdrawal() async {
    final amount = _selectedAmount;
    if (amount == null || _busy) return;
    if (widget.onContinue != null) {
      widget.onContinue!(amount);
      return;
    }
    final accountId = ref.read(sessionControllerProvider).accountId;
    if (accountId == null) return;
    setState(() => _busy = true);
    try {
      await ref
          .read(bankingServiceProvider)
          .spend(
            accountId: accountId,
            amount: amount,
            title: 'Tarik tunai demo',
            type: TransactionType.withdrawal,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tarik tunai berhasil (demo)')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e is StateError ? e.message : 'Tarik tunai gagal'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdrawal'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: ScrollableForm(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'withdrawal amount',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: _updateAmount,
                decoration: const InputDecoration(
                  labelText: 'Withdrawal amount (IDR)',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Suggested amounts',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              WithdrawalAmountSelector(
                selectedAmount: _selectedAmount,
                onAmountSelected: _selectAmount,
              ),
              const Spacer(),
              WithdrawalConfirmButton(
                enabled:
                    !_busy && _selectedAmount != null && _selectedAmount! > 0,
                onPressed: _continueWithdrawal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
