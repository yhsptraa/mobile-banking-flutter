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
              label: 'Bantuan',
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    title: const Text('Petunjuk layanan transfer'),
                    content: const Text(
                      'Transfer rekening baru: Anda dapat memasukkan nomor rekening yang belum pernah terdaftar sebelumnya' '\n\n'
                      'Transfer rekening lama: Anda dapat mentransfer ke nomor rekening yang pernah terdaftar sebelumnya'
                    ),
                    actions: [
                      AppButton(
                        label: 'Mengerti', 
                        onPressed: () => Navigator.pop(context)
                      )
                    ],
                  )
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
