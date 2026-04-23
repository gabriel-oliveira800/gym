import '../../shared/index.dart';
import '../database/index.dart';
import '../entity/index.dart';
import '../failure/failure.dart';

class TrainingRepository {
  final TrainingDao _dao;
  const TrainingRepository(this._dao);

  Training _toEntity(TrainingsTableData row) {
    return Training(
      id: row.id,
      name: row.name,
      createdAt: DateTime.parse(row.createdAt),
      updatedAt: DateTime.parse(row.updatedAt),
      weekdays: row.weekdays.isEmpty ? const [] : row.weekdays.toWeekdayList(),
    );
  }

  Exercise _toExerciseEntity(ExercisesTableData row) {
    return Exercise(
      id: row.id,
      name: row.name,
      urlId: row.urlId,
      workoutId: row.workoutId,
      workoutName: row.workoutName,
      createdAt: DateTime.parse(row.createdAt),
      updatedAt: DateTime.parse(row.updatedAt),
    );
  }

  Future<Result<Trainings>> getAll() async {
    try {
      final rows = await _dao.getAllTrainings();
      return Result.success(rows.map(_toEntity).toList());
    } catch (e, s) {
      return Result.failure(
        DatabaseFailure('Falha ao buscar treinos', cause: e, stackTrace: s),
      );
    }
  }

  Future<Result<Training>> getById(String id) async {
    try {
      final row = await _dao.getTrainingById(id);
      if (row == null) {
        return const Result.failure(NotFoundFailure('Treino não encontrado'));
      }
      return Result.success(_toEntity(row));
    } catch (e, s) {
      return Result.failure(
        DatabaseFailure('Falha ao buscar treino', cause: e, stackTrace: s),
      );
    }
  }

  Future<Result<Training>> create({
    required String name,
    required List<int> weekdays,
    required List<String> exerciseIds,
  }) async {
    try {
      final trimmed = name.trim();
      if (trimmed.isEmpty) {
        return const Result.failure(
          ValidationFailure('O nome do treino não pode ser vazio'),
        );
      }
      if (weekdays.isEmpty) {
        return const Result.failure(
          ValidationFailure('Selecione ao menos um dia da semana'),
        );
      }

      final row = await _dao.insertTraining(
        name: trimmed,
        weekdays: weekdays,
        exerciseIds: exerciseIds,
      );
      return Result.success(_toEntity(row));
    } catch (e, s) {
      return Result.failure(
        DatabaseFailure('Falha ao criar treino', cause: e, stackTrace: s),
      );
    }
  }

  Future<Result<Training>> update({
    required String id,
    required String name,
    required List<int> weekdays,
    required List<String> exerciseIds,
  }) async {
    try {
      final trimmed = name.trim();
      if (trimmed.isEmpty) {
        return const Result.failure(
          ValidationFailure('O nome do treino não pode ser vazio'),
        );
      }
      if (weekdays.isEmpty) {
        return const Result.failure(
          ValidationFailure('Selecione ao menos um dia da semana'),
        );
      }
      if (exerciseIds.isEmpty) {
        return const Result.failure(
          ValidationFailure('Selecione ao menos um exercício'),
        );
      }

      final existing = await _dao.getTrainingById(id);
      if (existing == null) {
        return const Result.failure(NotFoundFailure('Treino não encontrado'));
      }

      final row = await _dao.updateTraining(
        id: id,
        name: trimmed,
        weekdays: weekdays,
        exerciseIds: exerciseIds,
      );
      return Result.success(_toEntity(row));
    } catch (e, s) {
      return Result.failure(
        DatabaseFailure('Falha ao atualizar treino', cause: e, stackTrace: s),
      );
    }
  }

  Future<Result<Training>> joinOrRemoveExercise({
    required Training training,
    required List<String> exerciseIds,
  }) async {
    try {
      final existing = await _dao.getTrainingById(training.id);
      if (existing == null) {
        return const Result.failure(NotFoundFailure('Treino não encontrado'));
      }

      final row = await _dao.updateTraining(
        id: training.id,
        name: training.name,
        exerciseIds: exerciseIds,
        weekdays: training.weekdays,
      );
      return Result.success(_toEntity(row));
    } catch (e, s) {
      return Result.failure(
        DatabaseFailure('Falha ao atualizar treino', cause: e, stackTrace: s),
      );
    }
  }

  Future<Result<void>> delete(String id) async {
    try {
      await _dao.deleteTraining(id);
      return const Result.success(null);
    } catch (e, s) {
      return Result.failure(
        DatabaseFailure('Falha ao remover treino', cause: e, stackTrace: s),
      );
    }
  }

  Future<Result<Exercises>> getExercisesForTraining(String trainingId) async {
    try {
      final rows = await _dao.getExercisesForTraining(trainingId);
      return Result.success(rows.map(_toExerciseEntity).toList());
    } catch (e, s) {
      return Result.failure(
        DatabaseFailure(
          'Falha ao buscar exercícios do treino',
          cause: e,
          stackTrace: s,
        ),
      );
    }
  }

  Future<Result<Exercises>> getExercisesForWeekday(int weekday) async {
    try {
      final rows = await _dao.getExercisesForWeekday(weekday);
      return Result.success(rows.map(_toExerciseEntity).toList());
    } catch (e, s) {
      return Result.failure(
        DatabaseFailure(
          'Falha ao buscar exercícios do dia',
          cause: e,
          stackTrace: s,
        ),
      );
    }
  }
}
