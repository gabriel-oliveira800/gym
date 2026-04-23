import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';

import '../../core/entity/index.dart';
import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';

class ImageGalleryItem extends StatelessWidget {
  final bool isSelected;
  final ResourceField item;
  final ValueChanged<ResourceField> onSelected;

  const ImageGalleryItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(item),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radius8),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: AppSizes.borderWidthMedium,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                isSelected ? AppSizes.radius6 : 0,
              ),
              child: Image.asset(
                fit: BoxFit.cover,
                isSelected ? item.gifPath : item.previewPath,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.surface,
                  child: const Icon(
                    Icons.image,
                    color: AppColors.gray700,
                    size: AppSizes.iconMd,
                  ),
                ),
              ),
            ),
            if (isSelected)
              Container(
                color: AppColors.primary.withValues(
                  alpha: AppSizes.softTintLight,
                ),
                child: const Center(
                  child: Icon(
                    LucideIcons.checkCircle2,
                    size: AppSizes.iconXs,
                    color: AppColors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
