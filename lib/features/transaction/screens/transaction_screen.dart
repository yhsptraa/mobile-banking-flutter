import 'package:flutter/material.dart';
import '../../qris/qris.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String selectedFilter = 'Semua';
  int saldo = 100000000;

  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Transfer Masuk',
      'subtitle': 'Andi Saputra',
      'amount': '+ Rp 500.000',
      'time': '10:25',
      'isIncome': true,
    },
    {
      'title': 'Transfer Keluar',
      'subtitle': 'Budi Santoso',
      'amount': '- Rp 150.000',
      'time': '09:15',
      'isIncome': false,
    },
    {
      'title': 'Pembayaran',
      'subtitle': 'Tokopedia',
      'amount': '- Rp 250.000',
      'time': '08:30',
      'isIncome': false,
    },
    {
      'title': 'Transfer Masuk',
      'subtitle': 'Jesen',
      'amount': '+ Rp 1.000.000',
      'time': '07:45',
      'isIncome': true,
    },
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    if (selectedFilter == 'Masuk') {
      return transactions
          .where((transaction) => transaction['isIncome'] == true)
          .toList();
    }

    if (selectedFilter == 'Keluar') {
      return transactions
          .where((transaction) => transaction['isIncome'] == false)
          .toList();
    }

    return transactions;
  }

  Future<void> bukaQris() async {
    final isiQr = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => const QrisScreen(),
      ),
    );

    if (!mounted || isiQr == null) return;

    final nominalController = TextEditingController();

    final nominal = await showDialog<int>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Pembayaran QRIS'),
          content: TextField(
            controller: nominalController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Nominal pembayaran',
              prefixText: 'Rp ',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final angka = int.tryParse(
                  nominalController.text
                      .replaceAll('.', '')
                      .replaceAll(',', ''),
                );

                if (angka == null || angka <= 0) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(
                      content: Text('Masukkan nominal yang benar.'),
                    ),
                  );
                  return;
                }

                if (angka > saldo) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(
                      content: Text('Saldo tidak mencukupi.'),
                    ),
                  );
                  return;
                }

                Navigator.pop(dialogContext, angka);
              },
              child: const Text('Bayar'),
            ),
          ],
        );
      },
    );

    nominalController.dispose();

    if (nominal == null || !mounted) return;

    final sekarang = DateTime.now();
    final jam =
        '${sekarang.hour.toString().padLeft(2, '0')}:'
        '${sekarang.minute.toString().padLeft(2, '0')}';

    setState(() {
      saldo -= nominal;

      transactions.insert(0, {
        'title': 'Pembayaran QRIS',
        'subtitle': 'QRIS',
        'amount': '- Rp ${formatRupiah(nominal)}',
        'time': jam,
        'isIncome': false,
        'qrData': isiQr,
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Transaksi QRIS ditambahkan ke riwayat.'),
      ),
    );
  }

  String formatRupiah(int angka) {
    return angka.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (cocok) => '.',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text(
          'Riwayat Transaksi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Scan QRIS',
            onPressed: bukaQris,
            icon: const Icon(Icons.qr_code_scanner),
          ),
        ],
      ),
      body: Column(
        children: [
          // SALDO
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Saldo Anda',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rp ${formatRupiah(saldo)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // FILTER
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
            child: Row(
              children: [
                const Text(
                  'Filter By:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedFilter,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(
                            value: 'Semua',
                            child: Text('Semua Transaksi'),
                          ),
                          DropdownMenuItem(
                            value: 'Masuk',
                            child: Text('Uang Masuk'),
                          ),
                          DropdownMenuItem(
                            value: 'Keluar',
                            child: Text('Uang Keluar'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;

                          setState(() {
                            selectedFilter = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // LIST TRANSAKSI
          Expanded(
            child: filteredTransactions.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak ada transaksi',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = filteredTransactions[index];

                      return TransactionItem(
                        title: transaction['title'],
                        subtitle: transaction['subtitle'],
                        amount: transaction['amount'],
                        time: transaction['time'],
                        isIncome: transaction['isIncome'],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String time;
  final bool isIncome;

  const TransactionItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.time,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isIncome ? Colors.green.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isIncome ? Icons.south_west : Icons.north_east,
                color: isIncome ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                color: isIncome ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}