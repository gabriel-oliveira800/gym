import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BgLoading extends StatelessWidget {
  const BgLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }
}
