import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pusat Bantuan'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const Text(
            'Ada yang bisa kami bantu?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Temukan jawaban atas pertanyaan umum seputar aplikasi perbankan ini atau hubungi layanan pelanggan kami.',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 24),
          
          const Text(
            'Pertanyaan Populer (FAQ)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          
          ExpansionTile(
            title: const Text('Bagaimana cara mengubah nomor handphone?'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Anda dapat mengubah nomor handphone melalui menu Profil, klik ikon Edit di pojok kanan atas, ubah nomor handphone, lalu klik Simpan Perubahan.',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('Bagaimana cara mengganti password akun?'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Masuk ke menu Profil, pilih opsi "Ubah Password" di bagian Pengaturan Keamanan, lalu masukkan password lama dan password baru Anda.',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('Apakah data saya aman secara lokal?'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Ya, seluruh data profil dan kredensial disimpan secara lokal menggunakan database SQLite (Drift) pada perangkat Anda.',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          const Text(
            'Hubungi Kami',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: const Icon(Icons.phone_in_talk, color: Colors.blue),
              title: const Text('Call Center 24/7'),
              subtitle: const Text('0800-1-500-123'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Menghubungkan ke Call Center...')),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: const Icon(Icons.email_outlined, color: Colors.blue),
              title: const Text('Email Layanan'),
              subtitle: const Text('support@mobilebanking.com'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Membuka aplikasi email...')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}