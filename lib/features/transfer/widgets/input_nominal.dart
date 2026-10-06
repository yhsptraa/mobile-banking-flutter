import 'package:flutter/material.dart';
import '../../../core/widgets/app_input.dart';

class InputNominal extends StatelessWidget{
  final TextEditingController nominalController;

  const InputNominal({
    super.key, 
    required this.nominalController
  });

  @override
  Widget build(BuildContext context) {
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