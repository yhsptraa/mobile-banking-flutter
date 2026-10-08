import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../quick-menus/screens/withdrawal_screen.dart';
import '../../transfer/screens/transfer_screen.dart';
import '../../transaction/screens/transaction_screen.dart';
import '../../qris/payment_flow.dart';

class QuickMenu extends ConsumerWidget {
  const QuickMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void open(Widget screen) =>
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
    void payment(String title, {bool topUp = false}) =>
        demoPayment(context, ref, title: title, topUp: topUp);
    final menus = <({String label, IconData icon, VoidCallback action})>[
      (
        label: 'Transfer',
        icon: Icons.send_outlined,
        action: () => open(const TransferScreen()),
      ),
      (
        label: 'Billing',
        icon: Icons.receipt_long_outlined,
        action: () => payment('Pembayaran tagihan'),
      ),
      (
        label: 'Top Up',
        icon: Icons.account_balance_wallet_outlined,
        action: () => payment('Top Up', topUp: true),
      ),
      (
        label: 'e-Money',
        icon: Icons.contactless_outlined,
        action: () => payment('Isi e-Money'),
      ),
      (
        label: 'Transaction',
        icon: Icons.history,
        action: () => open(const TransactionScreen()),
      ),
      (
        label: 'Investment',
        icon: Icons.trending_up,
        action: () => payment('Investasi demo'),
      ),
      (
        label: 'Withdraw',
        icon: Icons.payments_outlined,
        action: () => open(const WithdrawalScreen()),
      ),
    ];
    Widget item(String label, IconData icon, VoidCallback action) => Expanded(
      child: InkWell(
        onTap: action,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, size: 28, color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: label == 'Transaction' || label == 'Investment'
                  ? const TextStyle(fontSize: 12)
                  : null,
            ),
          ],
        ),
      ),
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.textWhite,
      ),
      child: Column(
        children: [
          Row(
            children: [
              for (final menu in menus.take(4))
                item(menu.label, menu.icon, menu.action),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              for (final menu in menus.skip(4))
                item(menu.label, menu.icon, menu.action),
              item(
                'See all',
                Icons.apps,
                () => showModalBottomSheet(
                  context: context,
                  builder: (sheetContext) => SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (final menu in menus)
                            ListTile(
                              leading: Icon(menu.icon),
                              title: Text(menu.label),
                              onTap: () {
                                Navigator.pop(sheetContext);
                                menu.action();
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
