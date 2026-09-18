import 'package:flutter/material.dart';

import '../../../core/widgets/app_input.dart';
import '../../../core/widgets/app_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue[900], 
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
          ),
          const SizedBox(height: 32),

          const AppInput(label: 'Username'),
          const SizedBox(height: 16),
          const AppInput(label: 'Nomor Handphone'),
          const SizedBox(height: 32),

          const Text(
            'Pengaturan Keamanan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Card(
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.lock_outline, color: Colors.blue),
              title: const Text('Ubah Password'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                //TODO: Navigasi ke halaman ubah password
              },
            ),
          ),
          const SizedBox(height: 48),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: AppButton(
              label: 'Logout',
              onPressed: () {
              },
            ),
          ),
        ],
      ),
    );
  }
}