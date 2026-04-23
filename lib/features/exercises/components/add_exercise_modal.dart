import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';

import '../../../shared/index.dart';
import '../../../core/index.dart';

import '../exercises_controller.dart';

class AddExerciseModal extends StatefulWidget {
  final Workouts workouts;
  final ExercisesController controller;

  const AddExerciseModal({
    super.key,
    required this.workouts,
    required this.controller,
  });

  @override
  State<AddExerciseModal> createState() => _AddExerciseModalState();
}

class _AddExerciseModalState extends State<AddExerciseModal> {
  final ResourceRepository _resourceRepository = Binds.get<ResourceRepository>();

  String _name = '';
  bool _isLoading = false;
  DropdownItem? _selectedSegment;
  ResourceField? _selectedResource;

  bool get _canSave => _name.isNotEmpty && _selectedSegment != null;

  void _close() => Navigator.of(context).pop();

  void _onSegmentChanged(DropdownItem item) {
    setState(() {
      _selectedSegment = item;
      _selectedResource = null;
    });
    widget.controller.searchResources(item.label.toLowerCase());
  }

  Future<void> _save() async {
    if (!_canSave) return;
    setState(() => _isLoading = true);

    final workout = widget.workouts.firstWhere(
      (w) => w.id == _selectedSegment!.value,
    );

    final urlId = _selectedResource?.id ?? _resourceRepository.all().first.id;

    final result = await widget.controller.createExercise(
      name: _name,
      urlId: urlId,
      workoutId: workout.id,
      workoutName: workout.name,
    );

    if (!mounted) return;
    result.fold(
      onSuccess: (_) => _close(),
      onFailure: (failure) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
    );
  }

  @override
  void dispose() {
    widget.controller.clearSearch();
    super.dispose();
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
                      const Row(
                        children: [
                          Icon(
                            LucideIcons.sparkles,
                            size: AppSizes.iconMd,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: AppSizes.spacing8),
                          Text(
                            AppStrings.exercisesNewTitle,
                            style: AppTextStyles.modalTitle,
                          ),
                        ],
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
                  const SizedBox(height: AppSizes.spacing48),
                  InputWithLabel(
                    value: _name,
                    label: AppStrings.exerciseNameLabel,
                    placeholder: AppStrings.exerciseNamePlaceholder,
                    onChanged: (v) => setState(() => _name = v),
                  ),
                  const SizedBox(height: AppSizes.spacing20),
                  InputDropdown(
                    onChanged: _onSegmentChanged,
                    currentValue: _selectedSegment?.value,
                    label: AppStrings.exerciseSegmentsLabel,
                    placeholder: AppStrings.exerciseSegmentsPlaceholder,
                    items: widget.workouts.map((w) => DropdownItem(label: w.name, value: w.id)).toList(),
                  ),
                  const SizedBox(height: AppSizes.spacing20),
                  ValueListenableBuilder<ResourceFields>(
                    valueListenable: widget.controller.resourceSearch,
                    builder: (context, searchResults, _) {
                      return VisibleArea(
                        visible: _selectedSegment != null && searchResults.isNotEmpty,
                        placeholder: Container(
                          height: AppSizes.imageGalleryPlaceholder,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight.withValues(
                              alpha: AppSizes.softTint,
                            ),
                            borderRadius: BorderRadius.circular(AppSizes.radius12),
                            border: Border.all(
                              color: AppColors.surfaceLight,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              AppStrings.exerciseEmptySuggestions,
                              style: AppTextStyles.placeholderCenter,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputLabel(
                              label: '${AppStrings.exerciseSuggestionsPrefix}${_selectedSegment?.label ?? ""}',
                            ),
                            ImageGallery(
                              items: searchResults,
                              value: _selectedResource,
                              onSelected: (resource) {
                                setState(() {
                                  _selectedResource = resource;
                                  _name = resource.name;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
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
                  onPressed: _canSave ? _save : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
