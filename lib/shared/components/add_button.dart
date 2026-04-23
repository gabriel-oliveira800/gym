import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';

class AddButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;

  const AddButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = AppSizes.buttonSizeDefault,
    this.iconSize = AppSizes.iconMd,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSizes.radius12),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppSizes.radius12),
          child: Center(
            child: Icon(icon, size: iconSize, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
