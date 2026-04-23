import 'package:flutter/material.dart';

import '../../core/entity/index.dart';
import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';

import 'image_gallery_item.dart';

class ImageGallery extends StatelessWidget {
  final ResourceFields items;
  final ResourceField? value;
  final ValueChanged<ResourceField> onSelected;

  const ImageGallery({
    super.key,
    required this.items,
    this.value,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withValues(alpha: AppSizes.softTint),
        borderRadius: BorderRadius.circular(AppSizes.radius12),
        border: Border.all(
          color: AppColors.surfaceLight,
          style: BorderStyle.solid,
        ),
      ),
      padding: const EdgeInsets.all(AppSizes.spacing8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: AppSizes.spacing8,
          crossAxisSpacing: AppSizes.spacing8,
          crossAxisCount: AppSizes.gallerysColumns,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ImageGalleryItem(
            item: item,
            onSelected: onSelected,
            isSelected: value?.id == item.id,
          );
        },
      ),
    );
  }
}
