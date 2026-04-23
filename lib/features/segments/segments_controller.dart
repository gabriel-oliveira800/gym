import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../core/index.dart';
import '../../shared/index.dart';

class SegmentsController extends ValueNotifier<DefaultState<Workouts>> {
  final WorkoutRepository _workoutRepository;
  StreamSubscription<Workouts>? _subscription;

  SegmentsController(this._workoutRepository) : super(const InitialState<Workouts>());

  void start() {
    if (_subscription != null) return;
    value = const LoadingState();
    _subscription = _workoutRepository.watchAll().listen(
      (workouts) => value = SuccessState(workouts),
      onError: (Object e, StackTrace s) {
        value = ErrorState(
          UnknownFailure(e.toString(), cause: e, stackTrace: s),
        );
      },
    );
  }

  Future<Result<Workout>> createWorkout(String name) {
    return _workoutRepository.create(name);
  }

  Future<Result<void>> deleteWorkout(String id) {
    return _workoutRepository.delete(id);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
