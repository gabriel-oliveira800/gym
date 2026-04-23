import '../database/index.dart';
import '../failure/failure.dart';
import '../entity/index.dart';

class WorkoutRepository {
  final WorkoutDao _dao;

  WorkoutRepository(this._dao);

  Workout _toEntity(WorkoutsTableData row) {
    return Workout(
      id: row.id,
      name: row.name,
      createdAt: DateTime.parse(row.createdAt),
      updatedAt: DateTime.parse(row.updatedAt),
    );
  }

  Stream<Workouts> watchAll() {
    return _dao.watchAllWorkouts().map(
      (rows) => rows.map(_toEntity).toList(),
    );
  }

  Future<Result<Workouts>> getAll() async {
    try {
      final rows = await _dao.getAllWorkouts();
      return Result.success(rows.map(_toEntity).toList());
    } catch (e, s) {
      return Result.failure(
        DatabaseFailure('Falha ao buscar segmentos', cause: e, stackTrace: s),
      );
    }
  }

  Future<Result<Workout>> create(String name) async {
    try {
      final trimmed = name.trim();
      if (trimmed.isEmpty) {
        return const Result.failure(
          ValidationFailure('O nome do segmento não pode ser vazio'),
        );
      }
      final row = await _dao.insertWorkout(trimmed);
      return Result.success(_toEntity(row));
    } catch (e, s) {
      return Result.failure(
        DatabaseFailure('Falha ao criar segmento', cause: e, stackTrace: s),
      );
    }
  }

  Future<Result<void>> delete(String id) async {
    try {
      await _dao.deleteWorkout(id);
      return const Result.success(null);
    } catch (e, s) {
      return Result.failure(
        DatabaseFailure('Falha ao remover segmento', cause: e, stackTrace: s),
      );
    }
  }
}
