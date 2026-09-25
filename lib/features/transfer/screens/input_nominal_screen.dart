import 'package:flutter/material.dart';
import '../widgets/input_nominal.dart';
import '../widgets/template_nominal.dart';
import '../widgets/confirm_button_nominal.dart';

class InputNominalScreen extends StatefulWidget {
  final Map<String, String> dataAccount;

  const InputNominalScreen({
    super.key, 
    required this.dataAccount
  });

  @override
  State<InputNominalScreen> createState() => _InputNominalScreenState();
}

class _InputNominalScreenState extends State<InputNominalScreen> {
  final _nominalController = TextEditingController();

  @override
  void dispose() {
    _nominalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input nominal transfer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation:2,
              child: ListTile(
                title: Text(
                  widget.dataAccount['name'] ?? 'Penerima Rekening',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('No. Rek: ${widget.dataAccount['accountNumber'] ?? '-'}'),
              ),
            ),
            const SizedBox(height: 24),
            InputNominal(
              nominalController: _nominalController,
            ),
            const SizedBox(height: 20),
            const Text(
              'Pilihan nominal transfer',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            TemplateNominal(
              onSelectedNominal: (value) {
                setState(() {
                  _nominalController.text = value.toString();
                });
              },
            ),
            const Spacer(),
            ConfirmButtonNominal(
              nominalController: _nominalController,
              onConfirmed: () {
                // TODO: Navigasi ke TransferConfirmationScreen 
              },
            ),
          ],
        ),
      ),
    );
  }
}