import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

import '../widgets/home_header.dart';
import '../widgets/balance_card.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/quick_menu.dart';

import '../../profile/screens/profile_screen.dart';
import '../../transfer/screens/transfer_screen.dart';
import '../../qris/qris.dart';
import '../../transaction/screens/transaction_screen.dart';
import '../../notification/screens/notification_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _profile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProfileScreen()),
    );
  }

  void _notifications(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NotificationScreen()),
    );
  }

  void _transfers(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TransferScreen()),
    );
  }

  void _transactions(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const TransactionScreen(),
    ),
  );
}

  void _qris(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const QrisScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: HomeHeader(
                profilePage: () => _profile(context),
                notificationPage: () => _notifications(context),
                ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              sliver: SliverList.list(
                children: [
                  const BalanceCard(),
                  SizedBox(height: 16,),
                  const  QuickMenu()
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomBar(
        homePage: () {},
        transferPage: () => _transfers(context),
        transactionHistoryPage: () => _transactions(context),
        profilePage: () => _profile(context),
      ),
      floatingActionButton: QrisButton(
        onPressed: () => _qris(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
