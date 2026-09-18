import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({
    super.key,
    required this.onTransferTap,
    required this.onTransactionTap,
  });

  final VoidCallback onTransferTap;
  final VoidCallback onTransactionTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: AppColors.surface,
      elevation: 14,
      notchMargin: 8,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomBarItem(
            icon: Icons.send_outlined,
            label: 'Transfer',
            onTap: onTransferTap,
          ),
          const SizedBox(width: 72),
          BottomBarItem(
            icon: Icons.receipt_long_outlined,
            label: 'Transaksi',
            onTap: onTransactionTap,
          ),
        ],
      ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 3),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QrisButton extends StatelessWidget {
  const QrisButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'QRIS',
      onPressed: onPressed,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textWhite,
      shape: const CircleBorder(),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.qr_code_scanner_rounded, size: 26),
          SizedBox(height: 2),
          Text(
            'QRIS',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
