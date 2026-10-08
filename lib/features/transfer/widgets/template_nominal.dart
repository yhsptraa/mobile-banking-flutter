import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class TemplateNominal extends ConsumerWidget {
  final Function(int) onSelectedNominal;

  const TemplateNominal({
    super.key,
    required this.onSelectedNominal,
  });

  final List<int> nominalList = const [
    50000,
    100000,
    200000,
    300000,
    500000,
    1000000,
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: nominalList.map((nominal) {
        return ActionChip(
          backgroundColor: AppColors.primaryLight,
          side: const BorderSide(color: AppColors.border),
          label: Text(
            'Rp $nominal',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => onSelectedNominal(nominal),
        );
      }).toList(),
    );
  }
}