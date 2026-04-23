import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';

import '../../../core/index.dart';
import '../../../shared/index.dart';

class AddTrainingModal extends StatefulWidget {
  final Workouts workouts;
  const AddTrainingModal({super.key, required this.workouts});

  @override
  State<AddTrainingModal> createState() => _AddTrainingModalState();
}

class _AddTrainingModalState extends State<AddTrainingModal> {
  String _name = '';
  final bool _isLoading = false;
  final Set<String> _selectedDays = {};
  final Set<String> _selectedWorkouts = {};

  void _close() => Navigator.of(context).pop();

  void _toggleDay(String day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        _selectedDays.add(day);
      }
    });
  }

  void _toggleWorkout(String workoutId) {
    setState(() {
      if (_selectedWorkouts.contains(workoutId)) {
        _selectedWorkouts.remove(workoutId);
      } else {
        _selectedWorkouts.add(workoutId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * AppSizes.modalHeightRatio,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.radius24),
          topRight: Radius.circular(AppSizes.radius24),
        ),
        border: Border(top: BorderSide(color: AppColors.surfaceLight)),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        AppStrings.newTrainingTitle,
                        style: AppTextStyles.modalTitle,
                      ),
                      AppIconButton(
                        icon: const Icon(
                          LucideIcons.x,
                          size: AppSizes.iconXs,
                          color: AppColors.white,
                        ),
                        onPressed: _close,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacing32),
                  InputWithLabel(
                    label: AppStrings.trainingNameLabel,
                    placeholder: AppStrings.trainingNamePlaceholder,
                    value: _name,
                    onChanged: (v) => setState(() => _name = v),
                  ),
                  const SizedBox(height: AppSizes.spacing20),
                  Row(
                    children: daysOfWeek.map((day) {
                      final isSelected = _selectedDays.contains(day.value);
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacing2),
                          child: GestureDetector(
                            onTap: () => _toggleDay(day.value),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: AppSizes.spacing12),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary : AppColors.surfaceLight,
                                borderRadius: BorderRadius.circular(AppSizes.radius8),
                              ),
                              child: Center(
                                child: Text(
                                  day.label,
                                  style: isSelected ? AppTextStyles.dayLabelActive : AppTextStyles.dayLabelInactive,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSizes.spacing20),
                  const InputLabel(label: AppStrings.trainingSegmentsLabel),
                  Wrap(
                    spacing: AppSizes.spacing8,
                    runSpacing: AppSizes.spacing8,
                    children: widget.workouts.map((workout) {
                      final isSelected = _selectedWorkouts.contains(workout.id);
                      return GestureDetector(
                        onTap: () => _toggleWorkout(workout.id),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.spacing12,
                            vertical: AppSizes.spacing8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primaryMuted : Colors.transparent,
                            borderRadius: BorderRadius.circular(AppSizes.radius100),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.gray700,
                            ),
                          ),
                          child: Text(
                            workout.name,
                            style: isSelected ? AppTextStyles.chipActive : AppTextStyles.chipInactive,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppSizes.spacing16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.surfaceLight)),
            ),
            child: Row(
              children: [
                AppButton(
                  text: AppStrings.buttonCancel,
                  backgroundColor: AppColors.gray700,
                  onPressed: _close,
                ),
                const SizedBox(width: AppSizes.spacing12),
                AppButton(
                  text: AppStrings.buttonSave,
                  isLoading: _isLoading,
                  onPressed: _isLoading ? null : () {},
                  opacity: _isLoading ? AppSizes.disabledOpacity : 1.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
