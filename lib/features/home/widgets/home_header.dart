import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.profilePage, required this.notificationPage});

  final VoidCallback profilePage;
  final VoidCallback notificationPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: profilePage,
            borderRadius: BorderRadius.circular(28),
            child: const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jhon Doe',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                    '4315 8535 5438',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: notificationPage, 
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.textPrimary,
              size: 24,
            ),
            style: IconButton.styleFrom(
              side: const BorderSide(
                color: AppColors.textPrimary,
                width: 1.2,
              )
            ),
          )
        ],
      ),
    );
  }
}