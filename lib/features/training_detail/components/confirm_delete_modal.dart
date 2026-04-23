import 'package:flutter/material.dart';

import '../../../shared/index.dart';

class ConfirmDeleteModal extends StatelessWidget {
  const ConfirmDeleteModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      title: const Text(
        AppStrings.deleteTrainingTitle,
        style: AppTextStyles.modalTitle,
      ),
      content: const Text(
        AppStrings.deleteTrainingMessage,
        style: AppTextStyles.bodyGray,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            AppStrings.buttonCancel,
            style: TextStyle(color: AppColors.gray500),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            AppStrings.buttonDelete,
            style: TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
