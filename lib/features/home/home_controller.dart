import 'package:flutter/foundation.dart';

import '../../core/index.dart';
import '../../shared/index.dart';

class HomeData {
  final Trainings trainings;
  final Exercises todayExercises;
  final Exercises allExercises;

  const HomeData({
    required this.trainings,
    required this.todayExercises,
    required this.allExercises,
  });

  HomeData copyWith({
    Trainings? trainings,
    Exercises? todayExercises,
    Exercises? allExercises,
  }) {
    return HomeData(
      trainings: trainings ?? this.trainings,
      todayExercises: todayExercises ?? this.todayExercises,
      allExercises: allExercises ?? this.allExercises,
    );
  }
}

class HomeController extends ValueNotifier<DefaultState<HomeData>> {
  final TrainingRepository _trainingRepository;
  final ExerciseRepository _exerciseRepository;
  final ResourceRepository _resourceRepository;

  HomeController(
    this._trainingRepository,
    this._exerciseRepository,
    this._resourceRepository,
  ) : super(const InitialState<HomeData>());

  int get today => DateTime.now().weekday;

  Future<void> start() async {
    if (value.isLoading || value.isSuccess) return;
    await load();
  }

  Future<void> load() async {
    value = const LoadingState();
    try {
      final trainingsResult = await _trainingRepository.getAll();
      final trainings = trainingsResult.getValueOrNull() ?? const <Training>[];

      final exercisesResult = await _exerciseRepository.getAll();
      final allExercises = exercisesResult.getValueOrNull() ?? const <Exercise>[];

      final todayExsResult = await _trainingRepository.getExercisesForWeekday(today);
      final todayExs = todayExsResult.getValueOrNull() ?? const <Exercise>[];

      value = SuccessState(
        HomeData(
          trainings: trainings,
          todayExercises: todayExs,
          allExercises: allExercises,
        ),
      );
    } catch (e, s) {
      value = ErrorState(
        UnknownFailure(e.toString(), cause: e, stackTrace: s),
      );
    }
  }

  Future<Result<Training>> createTraining({
    required String name,
    required List<int> weekdays,
    required List<String> exerciseIds,
  }) async {
    final result = await _trainingRepository.create(
      name: name,
      weekdays: weekdays,
      exerciseIds: exerciseIds,
    );

    result.fold(
      onSuccess: (training) {
        final current = value.dataOrNull;
        if (current == null) return;

        final includesToday = training.isOnWeekday(today);
        final newTodayExs = includesToday
            ? [
                ...current.todayExercises,
                ...current.allExercises.where(
                  (e) => exerciseIds.contains(e.id) && !current.todayExercises.any((x) => x.id == e.id),
                ),
              ]
            : current.todayExercises;

        value = SuccessState(
          current.copyWith(
            trainings: [...current.trainings, training],
            todayExercises: newTodayExs,
          ),
        );
      },
      onFailure: (_) {},
    );

    return result;
  }

  /// Retorna um recurso aleatório (usado como fallback do carrossel).
  ResourceField randomResource() {
    final list = [..._resourceRepository.all()]..shuffle();
    return list.first;
  }

  ResourceField? resourceByIdOrNull(String id) {
    return _resourceRepository.findByIdOrNull(id);
  }
}
