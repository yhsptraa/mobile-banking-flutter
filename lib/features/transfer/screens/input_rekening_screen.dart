import 'package:flutter/material.dart';
import '../widgets/input_rekening.dart';
import '../widgets/confirm_button_rekening.dart';

class InputRekeningScreen extends StatefulWidget {
  const InputRekeningScreen({
    super.key
  });
  @override
  State<InputRekeningScreen> createState() => _InputRekeningScreenState();
}

class _InputRekeningScreenState extends State<InputRekeningScreen> {
  final _nameController = TextEditingController();
  final _accountController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _accountController.dispose();
    super.dispose();
  }

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
            InputRekening(
              nameController: _nameController,
              accountController: _accountController,
            ),
            const Spacer(),
            ConfirmButtonRekening(
              nameController: _nameController,
              accountController: _accountController,
              onConfirmed: (data) {
                Navigator.pop(context, data);
              },
            ),
          ],
        ),
      ),
    );
  }
}

