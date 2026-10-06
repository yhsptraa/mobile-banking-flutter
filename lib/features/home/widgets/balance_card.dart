import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';

class BalanceCard extends StatefulWidget {
  const BalanceCard({super.key});

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool _isBalanceVisible = false;

  void _toggleBalaceVisibility() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark]
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Balance',
                style: TextStyle(color: AppColors.textWhite, fontSize: 21),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  _isBalanceVisible ? 'Rp.100.000.000' : 'Rp. *******',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ), 
              ),
              IconButton(
                onPressed: _toggleBalaceVisibility,
                icon: Icon(
                  _isBalanceVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: AppColors.textWhite,
                  size: 28,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Divider(
            height: 8,
            thickness: 1,
            color: AppColors.textWhite,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '4315 8535 3459',
                style: TextStyle(color: AppColors.textWhite, fontSize: 16),
              ),
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: '431585353459'));

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Account Number Coppied!')
                    ),
                  );
                }, 
                icon: const Icon(
                  Icons.copy,
                  color: AppColors.textWhite,
                  size: 16,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}