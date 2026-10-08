import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/withdrawal_amount_selector.dart';
import '../widgets/withdrawal_confirm_button.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key, this.onContinue});

  final ValueChanged<int>? onContinue;

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  final _amountController = TextEditingController();
  int? _selectedAmount;

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

  void _continueWithdrawal() {
    final amount = _selectedAmount;
    if (amount != null) {
      widget.onContinue?.call(amount);
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
      body: Padding(
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
              enabled: _selectedAmount != null && _selectedAmount! > 0,
              onPressed: _continueWithdrawal,
            ),
          ],
        ),
      ),
    );
  }
}
