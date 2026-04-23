import 'package:flutter/foundation.dart';

import '../../core/index.dart';
import '../../shared/index.dart';

class TrainingDetailData {
  final Training training;
  final Exercises exercises;
  final Exercises allExercises;

  const TrainingDetailData({
    required this.training,
    required this.exercises,
    required this.allExercises,
  });

  TrainingDetailData copyWith({
    Training? training,
    Exercises? exercises,
    Exercises? allExercises,
  }) {
    return TrainingDetailData(
      training: training ?? this.training,
      exercises: exercises ?? this.exercises,
      allExercises: allExercises ?? this.allExercises,
    );
  }
}

class TrainingDetailController extends ValueNotifier<DefaultState<TrainingDetailData>> {
  final TrainingRepository _trainingRepository;
  final ExerciseRepository _exerciseRepository;

  TrainingDetailController(
    this._trainingRepository,
    this._exerciseRepository,
  ) : super(const InitialState<TrainingDetailData>());

  Future<void> load(String id) async {
    value = const LoadingState();
    try {
      final trainingResult = await _trainingRepository.getById(id);
      final training = trainingResult.getValueOrNull();
      if (training == null) {
        value = ErrorState(
          trainingResult.getFailureOrNull() ?? const NotFoundFailure('Treino não encontrado'),
        );
        return;
      }

      final exsResult = await _trainingRepository.getExercisesForTraining(id);
      final exercises = exsResult.getValueOrNull() ?? const <Exercise>[];

      final allExsResult = await _exerciseRepository.getAll();
      final allExercises = allExsResult.getValueOrNull() ?? const <Exercise>[];

      value = SuccessState(
        TrainingDetailData(
          training: training,
          exercises: exercises,
          allExercises: allExercises,
        ),
      );
    } catch (e, s) {
      value = ErrorState(
        UnknownFailure(e.toString(), cause: e, stackTrace: s),
      );
    }
  }

  Future<Result<Training>> update({
    required String name,
    required List<int> weekdays,
    required List<String> exerciseIds,
  }) async {
    final current = value.dataOrNull;
    if (current == null) {
      return const Result.failure(
        UnknownFailure('Treino ainda não carregado'),
      );
    }

    final result = await _trainingRepository.update(
      id: current.training.id,
      name: name,
      weekdays: weekdays,
      exerciseIds: exerciseIds,
    );

    result.fold(
      onSuccess: (updated) {
        final newExercises = current.allExercises.where((e) => exerciseIds.contains(e.id)).toList();

        value = SuccessState(
          current.copyWith(training: updated, exercises: newExercises),
        );
      },
      onFailure: (_) {},
    );

    return result;
  }

  Future<Result<void>> delete() async {
    final current = value.dataOrNull;
    if (current == null) {
      return const Result.failure(
        UnknownFailure('Treino ainda não carregado'),
      );
    }

    return _trainingRepository.delete(current.training.id);
  }

  Future<void> joinOrRemoveExercise(List<String> exerciseIds) async {
    final current = value.dataOrNull;
    if (current == null) return;

    final result = await _trainingRepository.joinOrRemoveExercise(
      exerciseIds: exerciseIds,
      training: current.training,
    );

    result.fold(
      onSuccess: (updated) {
        final newExercises = current.allExercises.where((e) => exerciseIds.contains(e.id)).toList();
        value = SuccessState(
          current.copyWith(training: updated, exercises: newExercises),
        );
      },
      onFailure: (_) {},
    );
  }
}
