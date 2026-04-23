import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';

import '../../../data/database/app_database.dart';
import '../../../shared/index.dart';

class AddTrainingModal extends ConsumerStatefulWidget {
  final List<WorkoutsTableData> workouts;

  const AddTrainingModal({super.key, required this.workouts});

  @override
  ConsumerState<AddTrainingModal> createState() => _AddTrainingModalState();
}

class _AddTrainingModalState extends ConsumerState<AddTrainingModal> {
  String _name = '';
  final bool _isLoading = false;
  final Set<String> _selectedDays = {};
  final Set<String> _selectedWorkouts = {};

  void _close() {
    Navigator.of(context).pop();
  }

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
                      const Text(
                        'Novo Plano de Treino',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppIconButton(
                        icon: const Icon(LucideIcons.x, size: 16, color: AppColors.white),
                        onPressed: _close,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Name input
                  InputWithLabel(
                    label: 'Nome do treino',
                    placeholder: 'Ex: Treino de Perna',
                    value: _name,
                    onChanged: (v) => setState(() => _name = v),
                  ),
                  const SizedBox(height: 20),

                  // Day selector
                  Row(
                    children: daysOfWeek.map((day) {
                      final isSelected = _selectedDays.contains(day.value);
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: GestureDetector(
                            onTap: () => _toggleDay(day.value),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary : AppColors.surfaceLight,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  day.label,
                                  style: TextStyle(
                                    color: isSelected ? AppColors.white : AppColors.gray500,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Segment selector
                  const InputLabel(label: 'Segmentos Alvo'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.workouts.map((workout) {
                      final isSelected = _selectedWorkouts.contains(workout.id);
                      return GestureDetector(
                        onTap: () => _toggleWorkout(workout.id),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primaryMuted : Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.gray700,
                            ),
                          ),
                          child: Text(
                            workout.name,
                            style: TextStyle(
                              color: isSelected ? AppColors.primary : AppColors.gray500,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
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
                  onPressed: _isLoading ? null : () {},
                  opacity: _isLoading ? 0.5 : 1.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
