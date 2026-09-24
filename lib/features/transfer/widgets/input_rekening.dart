import 'package:flutter/material.dart';

import '../../../core/widgets/app_input.dart';

class InputRekening extends StatelessWidget {
    final TextEditingController nameController;
    final TextEditingController accountController;

    const InputRekening({
      super.key,
      required this.nameController,
      required this.accountController,
    });

    @override
    Widget build(BuildContext context) {
        return Column(
            children: [
                AppInput(
                label: 'Nama pemilik rekening',
                controller: nameController,
                ),
                const SizedBox(
                    height: 16
                ),
                AppInput(
                label: 'Nomor rekening tujuan',
                controller: accountController,
                keyboardType: TextInputType.number,
                ),
            ],
        );
    }
}