import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../widget/notification_card.dart';
import '../widget/notification_section_title.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: const [
            SizedBox(height: 24),
            NotificationSectionTitle(title: 'Today'),
            SizedBox(height: 12),
            NotificationCard(
              icon: Icons.check_circle_outline_rounded,
              title: 'Transfer successful',
              message:
                  'Your transfer of Rp 250.000 to Budi Santoso was successful.',
              time: '10.25',
            ),
            NotificationCard(
              icon: Icons.receipt_long_outlined,
              title: 'Payment successful',
              message:
                  'Your electricity bill payment of Rp 325.000 was successful.',
              time: '08.40',
            ),
            SizedBox(height: 12),
            NotificationSectionTitle(title: 'Earlier'),
            SizedBox(height: 12),
            NotificationCard(
              icon: Icons.south_west_rounded,
              title: 'Incoming funds',
              message:
                  'You received a transfer of Rp 500.000 from Andi Saputra.',
              time: 'Yesterday, 16.12',
            ),
            NotificationCard(
              icon: Icons.shield_outlined,
              title: 'Account security',
              message: 'We detected a new login. Make sure this activity was performed by you.',
              time: '2 days ago',
            ),
          ],
        ),
      ),
    );
  }
}
