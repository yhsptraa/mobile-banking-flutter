import 'package:flutter/material.dart';
import '../widgets/input_rekening.dart';
import '../widgets/confirm_button_rekening.dart';

class InputRekeningScreen extends StatelessWidget {
  const InputRekeningScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambahkan rekening baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informasi rekening baru',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const InputRekening(),
            const Spacer(),
            ConfirmButtonRekening(
              onPressed: () {
                // TODO: Simpan rekening dan kembali ke transfer_screen
              },
            ),
          ],
        ),
      ),
    );
  }
}

