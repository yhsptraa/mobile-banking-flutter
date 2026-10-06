import 'package:flutter/material.dart';

class WithdrawalAmountSelector extends StatelessWidget {
  const WithdrawalAmountSelector({
    super.key,
    required this.selectedAmount,
    required this.onAmountSelected,
  });

  final int? selectedAmount;
  final ValueChanged<int> onAmountSelected;

  static const _amounts = [100000, 200000, 300000, 400000, 500000];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _amounts.map((amount) {
        return ChoiceChip(
          label: Text(formatIdr(amount)),
          selected: selectedAmount == amount,
          onSelected: (_) => onAmountSelected(amount),
        );
      }).toList(),
    );
  }
}

String formatIdr(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();

  for (var index = 0; index < digits.length; index++) {
    if (index > 0 && (digits.length - index) % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(digits[index]);
  }

  return 'IDR ${buffer.toString()}';
}
