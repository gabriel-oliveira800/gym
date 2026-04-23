import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../core/entity/workout.dart';
import '../../core/failure/failure.dart';
import '../../core/repository/workout_repository.dart';
import '../../shared/state/default_state.dart';

class HomeController extends ValueNotifier<DefaultState<Workouts>> {
  final WorkoutRepository _workoutRepository;
  StreamSubscription<Workouts>? _subscription;
  HomeController(this._workoutRepository) : super(const InitialState<Workouts>());

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

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
