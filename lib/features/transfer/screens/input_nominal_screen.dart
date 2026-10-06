import 'package:flutter/material.dart';
import '../widgets/input_nominal.dart';
import '../widgets/template_nominal.dart';
import '../widgets/confirm_button_nominal.dart';

class InputNominalScreen extends StatefulWidget {
  final List<Map<String, String>> dataAccounts;
  final Map<String, String>? initialAccount;

  const InputNominalScreen({
    super.key,
    required this.dataAccounts,
    this.initialAccount,
  });
  @override
  State<InputNominalScreen> createState() => _InputNominalScreenState();
}

class _InputNominalScreenState extends State<InputNominalScreen> {
  final _nominalController = TextEditingController();
  Map<String, String>? _selectedAccount;
  @override
  void initState() {
    super.initState();
    _selectedAccount = widget.initialAccount ??
        (widget.dataAccounts.isNotEmpty ? widget.dataAccounts.first : null);
  }
  @override
  void dispose() {
    _nominalController.dispose();
    super.dispose();
  }
  void _selectTemplateNominal(int value) {
    setState(() {
      _nominalController.text = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input nominal transfer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih rekening tujuan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<Map<String, String>>(
              value: _selectedAccount,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: widget.dataAccounts.map((account) {
                return DropdownMenuItem<Map<String, String>>(
                  value: account,
                  child: Text('${account['name']} (${account['accountNumber']})'),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedAccount = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            InputNominal(
              nominalController: _nominalController,
            ),
            const SizedBox(height: 16),
            const Text(
              'Pilihan nominal transfer',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            TemplateNominal(
              onSelectedNominal: _selectTemplateNominal,
            ),
            const Spacer(),
            ConfirmButtonNominal(
              nominalController: _nominalController,
              selectedAccount: _selectedAccount,
              onConfirmed: (transferData) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Konfirmasi transfer ke: ${transferData['name']} - Rp ${transferData['amount']}',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                // TODO: Navigasi ke TransferConfirmationScreen
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransferConfirmationScreen(
                      transferData: transferData,
                    ),
                  ),
                );
                */
              },
            ),
          ],
        ),
      ),
    );
  }
}