import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/app_input.dart';

class InputNominal extends ConsumerWidget {
  final TextEditingController nominalController;

  const InputNominal({
    super.key,
    required this.nominalController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        AppInput(
          label: 'Nominal transfer(Rp)',
          controller: nominalController,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}