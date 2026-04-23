import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';

class BgContainer extends StatelessWidget {
  final Widget child;

  const BgContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.pageHorizontal,
            vertical: AppSizes.pageVertical,
          ),
          child: child,
        ),
      ),
    );
  }
}
