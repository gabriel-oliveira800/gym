import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../../data/models/resource_field.dart';

class ImageGalleryItem extends StatelessWidget {
  final ResourceField item;
  final bool isSelected;
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
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              item.previewPath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.surface,
                child: const Icon(Icons.image, color: AppColors.gray700, size: 20),
              ),
            ),
            if (isSelected)
              Container(
                color: AppColors.primary.withValues(alpha: 0.2),
                child: const Center(
                  child: Icon(LucideIcons.checkCircle2, size: 16, color: AppColors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
