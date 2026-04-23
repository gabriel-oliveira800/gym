import 'package:drift/drift.dart';
import 'workouts_table.dart';

class ExercisesTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get urlId => text()();
  TextColumn get workoutId =>
      text().references(WorkoutsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get workoutName => text()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'exercises';
}
