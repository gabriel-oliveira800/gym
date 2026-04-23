import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../shared/theme/app_colors.dart';

class TrainingList extends StatelessWidget {
  final List<String> training;

  const TrainingList({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    if (training.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.gray700,
            style: BorderStyle.solid,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(LucideIcons.dumbbell, size: 48, color: AppColors.primary),
              SizedBox(height: 16),
              Text(
                'Nenhum treino hoje',
                style: TextStyle(color: AppColors.gray500, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: training.map((item) {
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Material(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: const Border(
                    left: BorderSide(color: AppColors.primary, width: 4),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: ['Dom', 'Seg', 'Ter'].map((day) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  day.toUpperCase(),
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.gray700,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Center(
                        child: Icon(LucideIcons.chevronRight,
                            size: 20, color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
