import 'package:drift/drift.dart';

class WorkoutsTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'workouts';
}
