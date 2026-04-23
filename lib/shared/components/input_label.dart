import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../theme/app_text_styles.dart';

class InputLabel extends StatelessWidget {
  final String label;

  const InputLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSizes.spacing16,
        left: AppSizes.spacing4,
      ),
      child: Text(label.toUpperCase(), style: AppTextStyles.smallLabel),
    );
  }
}
