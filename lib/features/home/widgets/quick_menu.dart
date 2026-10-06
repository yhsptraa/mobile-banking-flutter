import 'package:flutter/material.dart';
import 'package:mobile_banking_application/core/theme/app_colors.dart';
import 'package:mobile_banking_application/features/quick-menus/screens/withdrawal_screen.dart';

class QuickMenu extends StatelessWidget {
  const QuickMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.textWhite,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.send_outlined,
                        size: 28,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Transfer'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.receipt_long_outlined,
                        size: 28,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Billing'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        size: 28,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Top Up'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.contactless_outlined,
                        size: 28,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('e-Money'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.history,
                        size: 28,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Transaction', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.trending_up,
                        size: 28,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Investment', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WithdrawalScreen(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.payments_outlined,
                          size: 28,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('Withdraw'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.apps,
                        size: 28,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('See all'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
