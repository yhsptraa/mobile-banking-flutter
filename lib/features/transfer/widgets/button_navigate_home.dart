import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/app_button.dart';

class ButtonNavigateHome extends ConsumerWidget {
  final VoidCallback? onPressed;

  const ButtonNavigateHome({super.key, this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: AppButton(
        label: 'Kirim',
        onPressed: onPressed ??
            () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
      ),
    );
  }
}