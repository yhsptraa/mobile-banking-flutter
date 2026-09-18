import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Balance',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Rp 103.054.369',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            '4315 8535 3459 5438',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
        ],
      ),
    );
  }
}