import 'package:flutter/material.dart';

import '../../../core/widgets/app_input.dart';

class InputRekening extends StatelessWidget {
    const InputRekening({
        super.key
    });

    @override
    Widget build(BuildContext context) {
        return Column(
            children: [
                AppInput(
                label: 'Nama pemilik rekening',
                ),
                const SizedBox(
                    height: 16
                ),
                AppInput(
                label: 'Nomor rekening tujuan',
                ),
            ],
        );
    }
}