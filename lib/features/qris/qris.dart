import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrisScreen extends StatefulWidget {
  const QrisScreen({super.key});

  @override
  State<QrisScreen> createState() => _QrisScreenState();
}

class _QrisScreenState extends State<QrisScreen> {
  final MobileScannerController scannerController = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );

  final ImagePicker imagePicker = ImagePicker();
  bool sudahDibaca = false;

  void kirimHasil(String? isiQr) {
    if (!mounted || sudahDibaca || isiQr == null || isiQr.isEmpty) return;

    sudahDibaca = true;
    Navigator.pop(context, isiQr);
  }

  Future<void> pilihDariGaleri() async {
    try {
      final gambar = await imagePicker.pickImage(source: ImageSource.gallery);

      if (!mounted || gambar == null) return;

      final hasil = await scannerController.analyzeImage(gambar.path);
      final daftarBarcode = hasil?.barcodes ?? [];

      if (daftarBarcode.isNotEmpty) {
        kirimHasil(daftarBarcode.first.rawValue);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('QR tidak ditemukan di gambar.')),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal membaca gambar QR. Coba kembali.'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QRIS'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              controller: scannerController,
              onDetect: (hasil) {
                if (hasil.barcodes.isNotEmpty) {
                  kirimHasil(hasil.barcodes.first.rawValue);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: pilihDariGaleri,
                icon: const Icon(Icons.photo_library),
                label: const Text('Pilih QR dari Galeri'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
