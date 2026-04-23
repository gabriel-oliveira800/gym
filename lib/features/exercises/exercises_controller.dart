import 'package:flutter/foundation.dart';
import 'dart:async';

import '../../core/index.dart';
import '../../shared/index.dart';

class ExercisesData {
  final Workouts workouts;
  final Exercises exercises;

  const ExercisesData({required this.exercises, required this.workouts});
}

class ExercisesController extends ValueNotifier<DefaultState<ExercisesData>> {
  final ExerciseRepository _exerciseRepository;
  final WorkoutRepository _workoutRepository;
  final ResourceRepository _resourceRepository;

  StreamSubscription<Workouts>? _workoutSub;
  StreamSubscription<Exercises>? _exerciseSub;

  bool _exercisesReady = false;
  bool _workoutsReady = false;

  Workouts _workouts = const [];
  Exercises _exercises = const [];

  final resourceSearch = ValueNotifier<ResourceFields>(const []);

  ExercisesController(
    this._exerciseRepository,
    this._workoutRepository,
    this._resourceRepository,
  ) : super(const InitialState<ExercisesData>());

  void start() {
    if (_exerciseSub != null || _workoutSub != null) return;
    value = const LoadingState();

    _exerciseSub = _exerciseRepository.watchAll().listen(
      (list) {
        _exercises = list;
        _exercisesReady = true;
        _emit();
      },
      onError: _onError,
    );

    _workoutSub = _workoutRepository.watchAll().listen(
      (list) {
        _workouts = list;
        _workoutsReady = true;
        _emit();
      },
      onError: _onError,
    );
  }

  void _emit() {
    if (!_exercisesReady || !_workoutsReady) return;
    value = SuccessState(
      ExercisesData(exercises: _exercises, workouts: _workouts),
    );
  }

  void _onError(Object e, StackTrace s) {
    value = ErrorState(
      UnknownFailure(e.toString(), cause: e, stackTrace: s),
    );
  }

  void searchResources(String segment) {
    resourceSearch.value = _resourceRepository.search(segment);
  }

  void clearSearch() {
    resourceSearch.value = const [];
  }

  Future<Result<Exercise>> createExercise({
    required String name,
    required String urlId,
    required String workoutId,
    required String workoutName,
  }) {
    return _exerciseRepository.create(
      name: name,
      urlId: urlId,
      workoutId: workoutId,
      workoutName: workoutName,
    );
  }

  Future<Result<void>> deleteExercise(String id) {
    return _exerciseRepository.delete(id);
  }

  @override
  void dispose() {
    _exerciseSub?.cancel();
    _workoutSub?.cancel();
    resourceSearch.dispose();
    super.dispose();
  }
}
