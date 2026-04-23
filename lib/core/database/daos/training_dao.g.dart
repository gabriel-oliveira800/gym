// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_dao.dart';

// ignore_for_file: type=lint
mixin _$TrainingDaoMixin on DatabaseAccessor<AppDatabase> {
  $TrainingsTableTable get trainingsTable => attachedDatabase.trainingsTable;
  $WorkoutsTableTable get workoutsTable => attachedDatabase.workoutsTable;
  $ExercisesTableTable get exercisesTable => attachedDatabase.exercisesTable;
  $TrainingExercisesTableTable get trainingExercisesTable =>
      attachedDatabase.trainingExercisesTable;
  TrainingDaoManager get managers => TrainingDaoManager(this);
}

class TrainingDaoManager {
  final _$TrainingDaoMixin _db;
  TrainingDaoManager(this._db);
  $$TrainingsTableTableTableManager get trainingsTable =>
      $$TrainingsTableTableTableManager(
        _db.attachedDatabase,
        _db.trainingsTable,
      );
  $$WorkoutsTableTableTableManager get workoutsTable =>
      $$WorkoutsTableTableTableManager(_db.attachedDatabase, _db.workoutsTable);
  $$ExercisesTableTableTableManager get exercisesTable =>
      $$ExercisesTableTableTableManager(
        _db.attachedDatabase,
        _db.exercisesTable,
      );
  $$TrainingExercisesTableTableTableManager get trainingExercisesTable =>
      $$TrainingExercisesTableTableTableManager(
        _db.attachedDatabase,
        _db.trainingExercisesTable,
      );
}
