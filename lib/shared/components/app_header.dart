import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Widget? trailing;

  const AppHeader({
    super.key,
    required this.title,
    this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(title, style: AppTextStyles.headerXl),
            if (icon != null) ...[
              const SizedBox(width: AppSizes.spacing8),
              Icon(icon, color: AppColors.primary, size: AppSizes.iconLg),
            ],
          ],
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
