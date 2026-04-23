import 'package:flutter/material.dart';
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
    this.size = 64,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Icon(icon, size: iconSize, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
