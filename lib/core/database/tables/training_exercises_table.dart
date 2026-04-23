import 'package:drift/drift.dart';

import 'exercises_table.dart';
import 'trainings_table.dart';

class TrainingExercisesTable extends Table {
  TextColumn get trainingId => text().references(TrainingsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get exerciseId => text().references(ExercisesTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {trainingId, exerciseId};

  @override
  String get tableName => 'training_exercises';
}
