import '../failure/failure.dart';
import '../database/index.dart';
import '../entity/index.dart';

class ExerciseRepository {
  final ExerciseDao _dao;
  const ExerciseRepository(this._dao);

  Exercise _toEntity(ExercisesTableData row) {
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

  Stream<Exercises> watchAll() {
    return _dao.watchAllExercises().map(
      (rows) => rows.map(_toEntity).toList(),
    );
  }

  Future<Result<Exercises>> getAll() async {
    try {
      final rows = await _dao.getAllExercises();
      return Result.success(rows.map(_toEntity).toList());
    } catch (e, s) {
      return Result.failure(
        DatabaseFailure('Falha ao buscar exercícios', cause: e, stackTrace: s),
      );
    }
  }

  Future<Result<Exercise>> create({
    required String name,
    required String urlId,
    required String workoutId,
    required String workoutName,
  }) async {
    try {
      if (name.trim().isEmpty) {
        return const Result.failure(
          ValidationFailure('O nome do exercício não pode ser vazio'),
        );
      }
      final row = await _dao.insertExercise(
        name: name,
        urlId: urlId,
        workoutId: workoutId,
        workoutName: workoutName,
      );
      return Result.success(_toEntity(row));
    } catch (e, s) {
      return Result.failure(
        DatabaseFailure('Falha ao criar exercício', cause: e, stackTrace: s),
      );
    }
  }

  Future<Result<void>> delete(String id) async {
    try {
      await _dao.deleteExercise(id);
      return const Result.success(null);
    } catch (e, s) {
      return Result.failure(
        DatabaseFailure('Falha ao remover exercício', cause: e, stackTrace: s),
      );
    }
  }
}
