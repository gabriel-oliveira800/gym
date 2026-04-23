import 'package:flutter/material.dart';

import '../../shared/index.dart';
import '../../core/index.dart';
import '../home/index.dart';

import 'training_detail_controller.dart';
import 'components/index.dart';

class TrainingDetailScreen extends StatefulWidget {
  final String id;
  const TrainingDetailScreen({super.key, required this.id});

  @override
  State<TrainingDetailScreen> createState() => _TrainingDetailScreenState();
}

class _TrainingDetailScreenState extends State<TrainingDetailScreen> {
  late final TrainingDetailController _controller;
  late final ResourceRepository _resourceRepository;

  @override
  void initState() {
    super.initState();
    _controller = Binds.get<TrainingDetailController>();
    _resourceRepository = Binds.get<ResourceRepository>();
    _controller.load(widget.id);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openEditModal(TrainingDetailData data) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddTrainingModal(
        training: data.training,
        onSave: _controller.update,
        exercises: data.allExercises,
        initialExerciseIds: data.exercises.map((e) => e.id).toList(),
        onDelete: () async {
          final result = await _controller.delete();
          if (result.isSuccess) AppNavigation.toHome();
          return result;
        },
      ),
    );
  }

  void _joinNewExerciseModal(TrainingDetailData data) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => JoinOrRemoveExerciseModal(
        training: data.training,
        exercises: data.allExercises,
        onSave: _controller.joinOrRemoveExercise,
        initialExerciseIds: data.exercises.map((e) => e.id).toList(),
      ),
    );
  }

  Future<void> _confirmAndDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      useRootNavigator: true,
      builder: (ctx) => ConfirmDeleteModal(),
    );

    if (!mounted || confirmed != true) return;

    final result = await _controller.delete();
    if (!mounted) return;
    result.fold(
      onSuccess: (_) => AppNavigation.toHome(),
      onFailure: (failure) => Helpers.showSnackBar(failure.message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: DetailsHeader(
        controller: _controller,
        openEditModal: _openEditModal,
        confirmAndDelete: _confirmAndDelete,
        joinExercise: _joinNewExerciseModal,
      ),
      body: StateBuilder<TrainingDetailData>(
        listenable: _controller,
        success: (context, data) {
          return BgContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.training.name, style: AppTextStyles.modalTitle),
                const SizedBox(height: AppSizes.spacing8),
                _WeekdayRow(weekdays: data.training.weekdays),
                const SizedBox(height: AppSizes.spacing24),
                const InputLabel(
                  label: AppStrings.trainingDetailExercisesLabel,
                ),
                Expanded(
                  child: data.exercises.isEmpty
                      ? const Center(
                          child: Text(
                            AppStrings.trainingDetailEmpty,
                            style: AppTextStyles.emptyStateText,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.separated(
                          itemCount: data.exercises.length,
                          separatorBuilder: (_, __) => const SizedBox(
                            height: AppSizes.spacing12,
                          ),
                          itemBuilder: (context, index) {
                            final ex = data.exercises[index];
                            return TrainingExerciseItem(
                              exercise: ex,
                              resource: _resourceRepository.findByIdOrNull(ex.urlId),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _WeekdayRow extends StatelessWidget {
  final List<int> weekdays;
  const _WeekdayRow({required this.weekdays});

  @override
  Widget build(BuildContext context) {
    final sorted = [...weekdays]..sort();
    return Wrap(
      spacing: AppSizes.spacing8,
      runSpacing: AppSizes.spacing8,
      children: sorted.map((d) {
        final label = weekdayShortLabel(d);
        if (label.isEmpty) return const SizedBox.shrink();
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacing12,
            vertical: AppSizes.spacing4,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: AppSizes.softTintMin),
            borderRadius: BorderRadius.circular(AppSizes.radius100),
            border: Border.all(color: AppColors.primary),
          ),
          child: Text(label.toUpperCase(), style: AppTextStyles.segmentTag),
        );
      }).toList(),
    );
  }
}
