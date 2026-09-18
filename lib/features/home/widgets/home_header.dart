import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.onProfileTap});

  final VoidCallback onProfileTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryDark, AppColors.primary],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onProfileTap,
            borderRadius: BorderRadius.circular(28),
            child: const CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.surface,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi,',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
                SizedBox(height: 4),
                Text(
                  'Jhon Doe',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}