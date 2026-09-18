import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

import '../widgets/home_header.dart';
import '../widgets/balance_card.dart';
import '../widgets/bottom_navbar.dart';

import '../../profile/screens/profile_screen.dart';
import '../../transfer/screens/transfer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _profile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProfileScreen()),
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
      MaterialPageRoute(builder: (_) => const TempScreen()),
    );
  }

  void _qris(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('fitur akan segera tersedia')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: HomeHeader(onProfileTap: () => _profile(context)),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
              sliver: SliverList.list(
                children: [
                  const BalanceCard()
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomBar(
        onTransferTap: () => _transfers(context),
        onTransactionTap: () => _transactions(context),
      ),
      floatingActionButton: QrisButton(
        onPressed: () => _qris(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
class TempScreen extends StatelessWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Center(child: Text('On Going')));
  }
}
