import 'package:flutter/material.dart';

import '../../../core/widgets/app_button.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
        backgroundColor: Colors.blue[900], 
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const Text(
            'Pilih layanan transfer',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          Card(
            elevation: 2,
            child: ListTile(
              title: const Text('Transfer rekening baru'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                //TODO: Navigasi ke halaman input rekening
              },
            ),
          ),

          Card(
            elevation: 2,
            child: ListTile(
              title: const Text('Transfer rekening lama'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                //TODO: Navigasi ke halaman input nominal
              },
            ),
          ),
          
          const SizedBox(height: 48),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: AppButton(
              label: 'Kembali',
              onPressed: () {
              },
            ),
          ),
        ],
      ),
    );
  }
}
