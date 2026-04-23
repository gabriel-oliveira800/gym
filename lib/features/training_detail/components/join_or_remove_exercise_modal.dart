import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';

import '../../../shared/index.dart';
import '../../../core/index.dart';

typedef OnSave = Future<void> Function(List<String>);

class JoinOrRemoveExerciseModal extends StatefulWidget {
  final OnSave onSave;
  final Training? training;
  final Exercises exercises;
  final List<String> initialExerciseIds;

  const JoinOrRemoveExerciseModal({
    super.key,
    this.training,
    required this.onSave,
    required this.exercises,
    this.initialExerciseIds = const [],
  });

  @override
  State<JoinOrRemoveExerciseModal> createState() => _JoinOrRemoveExerciseModalState();
}

class _JoinOrRemoveExerciseModalState extends State<JoinOrRemoveExerciseModal> {
  bool _canSave = false;
  bool _isLoading = false;
  late final Set<String> _selectedExercises;

  @override
  void initState() {
    super.initState();
    _selectedExercises = {...widget.initialExerciseIds};
  }

  void _close() => Navigator.of(context).pop();

  void _toggleExercise(String exerciseId) {
    setState(() {
      _canSave = true;
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

    await widget.onSave(_selectedExercises.toList());
    _close();
  }

  @override
  Widget build(BuildContext context) {
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
                            AppStrings.joinExerciseTitle,
                            style: AppTextStyles.modalTitle,
                            overflow: TextOverflow.ellipsis,
                          ),
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
                    onPressed: _close,
                    text: AppStrings.buttonCancel,
                    backgroundColor: AppColors.gray700,
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
