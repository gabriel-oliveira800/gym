import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/resource_field.dart';
import '../../../providers/exercise_provider.dart';
import '../../../providers/resource_provider.dart';

import '../../../shared/index.dart';

class AddExerciseModal extends ConsumerStatefulWidget {
  final List<WorkoutsTableData> workouts;

  const AddExerciseModal({super.key, required this.workouts});

  @override
  ConsumerState<AddExerciseModal> createState() => _AddExerciseModalState();
}

class _AddExerciseModalState extends ConsumerState<AddExerciseModal> {
  String _name = '';
  bool _isLoading = false;
  ResourceField? _selectedResource;
  DropdownItem? _selectedSegment;

  bool get _canSave => _name.isNotEmpty && _selectedSegment != null;

  void _close() {
    Navigator.of(context).pop();
  }

  void _onSegmentChanged(DropdownItem item) {
    setState(() {
      _selectedSegment = item;
      _selectedResource = null;
    });
    ref.read(resourceSearchProvider.notifier).search(item.label.toLowerCase());
  }

  Future<void> _save() async {
    if (!_canSave) return;
    setState(() => _isLoading = true);

    final workout = widget.workouts.firstWhere(
      (w) => w.id == _selectedSegment!.value,
    );

    final urlId = _selectedResource?.id ?? resources.first.id;

    await ref.read(exerciseDaoProvider).insertExercise(
          name: _name,
          urlId: urlId,
          workoutId: workout.id,
          workoutName: workout.name,
        );

    if (mounted) _close();
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(resourceSearchProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border(top: BorderSide(color: AppColors.surfaceLight)),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(LucideIcons.sparkles,
                              size: 20, color: AppColors.primary),
                          SizedBox(width: 8),
                          Text(
                            'Novo Exercício',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      AppIconButton(
                        icon: const Icon(LucideIcons.x,
                            size: 16, color: AppColors.white),
                        onPressed: _close,
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),

                  // Name input
                  InputWithLabel(
                    label: 'Nome do Exercício',
                    placeholder: 'Ex: Rosca Martelo',
                    value: _name,
                    onChanged: (v) => setState(() => _name = v),
                  ),
                  const SizedBox(height: 20),

                  // Segment dropdown
                  InputDropdown(
                    label: 'Segmentos',
                    placeholder: 'Selecione o segmento',
                    currentValue: _selectedSegment?.value,
                    items: widget.workouts
                        .map((w) => DropdownItem(label: w.name, value: w.id))
                        .toList(),
                    onChanged: _onSegmentChanged,
                  ),
                  const SizedBox(height: 20),

                  // Image gallery
                  VisibleArea(
                    visible:
                        _selectedSegment != null && searchResults.isNotEmpty,
                    placeholder: Container(
                      height: 256,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.surfaceLight,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Selecione um segmento para ver sugestões de fotos.',
                          style: TextStyle(
                              color: AppColors.gray600, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputLabel(
                            label:
                                'Sugestões para ${_selectedSegment?.label ?? ""}'),
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
                  ),
                ],
              ),
            ),
          ),

          // Action buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.surfaceLight)),
            ),
            child: Row(
              children: [
                AppButton(
                  text: 'Cancelar',
                  backgroundColor: AppColors.gray700,
                  onPressed: _close,
                ),
                const SizedBox(width: 12),
                AppButton(
                  text: 'Salvar',
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
