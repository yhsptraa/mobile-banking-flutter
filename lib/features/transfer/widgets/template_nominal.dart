import 'package:flutter/material.dart';

class TemplateNominal extends StatelessWidget {
  final Function(int) onSelectedNominal;

  const TemplateNominal({
    super.key, 
    required this.onSelectedNominal
  });

  final List<int> nominalList = const [
    50000,
    100000,
    200000,
    300000,
    500000,
    1000000
  ];
  
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: nominalList.map((nominal) {
        return ActionChip(
          label: Text(nominal.toString()),
          onPressed: () => onSelectedNominal(nominal),
        );
      }).toList(),
    );
  }
}