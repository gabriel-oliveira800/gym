import 'package:drift/drift.dart';

class TrainingsTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get weekdays => text()(); // CSV: "1,3,5" (DateTime.weekday)
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'trainings';
}
