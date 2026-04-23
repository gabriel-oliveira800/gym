import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../../data/models/resource_field.dart';
import 'image_gallery_item.dart';

class ImageGallery extends StatelessWidget {
  final List<ResourceField> items;
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
        color: AppColors.surfaceLight.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.surfaceLight,
          style: BorderStyle.solid,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ImageGalleryItem(
            item: item,
            isSelected: value?.id == item.id,
            onSelected: onSelected,
          );
        },
      ),
    );
  }
}
