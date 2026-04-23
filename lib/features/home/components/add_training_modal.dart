import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/index.dart';
import '../../../shared/index.dart';
import '../../training_detail/index.dart';

typedef OnSaveTraining =
    Future<Result<Training>> Function({
      required String name,
      required List<int> weekdays,
      required List<String> exerciseIds,
    });

typedef OnDeleteTraining = Future<Result<void>> Function();

class AddTrainingModal extends StatefulWidget {
  final Exercises exercises;
  final Training? training;
  final OnSaveTraining onSave;
  final OnDeleteTraining? onDelete;
  final List<String> initialExerciseIds;

  const AddTrainingModal({
    super.key,
    this.training,
    this.onDelete,
    required this.onSave,
    required this.exercises,
    this.initialExerciseIds = const [],
  });

  bool get isEdit => training != null;

  @override
  State<AddTrainingModal> createState() => _AddTrainingModalState();
}

class _AddTrainingModalState extends State<AddTrainingModal> {
  late String _name;
  bool _isLoading = false;
  bool _isDeleting = false;
  late final Set<int> _selectedDays;
  late final Set<String> _selectedExercises;

  @override
  void initState() {
    super.initState();
    _name = widget.training?.name ?? '';
    _selectedDays = {...?widget.training?.weekdays};
    _selectedExercises = {...widget.initialExerciseIds};
  }

  bool get _canSave => _name.trim().isNotEmpty && _selectedDays.isNotEmpty && !_isLoading && !_isDeleting;

  void _close() => Navigator.of(context).pop();

  void _toggleDay(int day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        _selectedDays.add(day);
      }
    });
  }

  void _toggleExercise(String exerciseId) {
    setState(() {
      if (_selectedExercises.contains(exerciseId)) {
        _selectedExercises.remove(exerciseId);
      } else {
        _selectedExercises.add(exerciseId);
      }
    });
  }

  Future<void> _save() async {
    if (!_canSave) return;
    setState(() => _isLoading = true);

    final result = await widget.onSave(
      name: _name,
      weekdays: _selectedDays.toList()..sort(),
      exerciseIds: _selectedExercises.toList(),
    );

    if (!mounted) return;
    result.fold(
      onSuccess: (_) => _close(),
      onFailure: (failure) {
        setState(() => _isLoading = false);
        Helpers.showSnackBar(failure.message);
      },
    );
  }

  Future<void> _delete() async {
    final onDelete = widget.onDelete;
    if (onDelete == null || _isDeleting) return;

    final confirmed = await _confirmDelete();
    if (!mounted || confirmed != true) return;

    setState(() => _isDeleting = true);
    final result = await onDelete();

    if (!mounted) return;
    result.fold(
      onSuccess: (_) => _close(),
      onFailure: (failure) {
        setState(() => _isDeleting = false);
        Helpers.showSnackBar(failure.message);
      },
    );
  }

  Future<bool?> _confirmDelete() {
    return showDialog<bool>(
      context: context,
      useRootNavigator: true,
      builder: (ctx) => ConfirmDeleteModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isEdit ? AppStrings.editTrainingTitle : AppStrings.newTrainingTitle;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSizes.radius24),
            topRight: Radius.circular(AppSizes.radius24),
          ),
          border: Border(top: BorderSide(color: AppColors.surfaceLight)),
        ),
        padding: const EdgeInsets.only(top: AppSizes.spacing24),
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
                        Expanded(
                          child: Text(
                            title,
                            style: AppTextStyles.modalTitle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (widget.onDelete != null) ...[
                          _DeleteIconButton(
                            isLoading: _isDeleting,
                            onPressed: _delete,
                          ),
                          const SizedBox(width: AppSizes.spacing8),
                        ],
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
                      value: _name,
                      label: AppStrings.trainingNameLabel,
                      placeholder: AppStrings.trainingNamePlaceholder,
                      onChanged: (v) => setState(() => _name = v),
                    ),
                    const SizedBox(height: AppSizes.spacing20),
                    const InputLabel(label: AppStrings.trainingDaysLabel),
                    Row(
                      children: daysOfWeek.map((day) {
                        final isSelected = _selectedDays.contains(day.value);
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.spacing2,
                            ),
                            child: GestureDetector(
                              onTap: () => _toggleDay(day.value),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSizes.spacing12,
                                ),
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
                    const SizedBox(height: AppSizes.spacing24),
                    const InputLabel(label: AppStrings.trainingExercisesLabel),
                    ExerciseSelector(
                      onToggle: _toggleExercise,
                      exercises: widget.exercises,
                      selectedIds: _selectedExercises,
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
                    isLoading: _isLoading,
                    text: AppStrings.buttonSave,
                    onPressed: _canSave ? _save : null,
                    opacity: _isLoading ? AppSizes.disabledOpacity : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeleteIconButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _DeleteIconButton({
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: AppSizes.iconButtonSize,
        height: AppSizes.iconButtonSize,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: AppSizes.softTintMin),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: AppSizes.iconXs,
                  height: AppSizes.iconXs,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                )
              : const Icon(
                  LucideIcons.trash2,
                  size: AppSizes.iconXs,
                  color: AppColors.primary,
                ),
        ),
      ),
    );
  }
}
