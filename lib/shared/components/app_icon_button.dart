import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';

class AppIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;

  const AppIconButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: AppSizes.iconButtonSize,
        height: AppSizes.iconButtonSize,
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.gray700,
            width: AppSizes.borderWidthThin,
          ),
        ),
        child: Center(child: icon),
      ),
    );
  }
}
