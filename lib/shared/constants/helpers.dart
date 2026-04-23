import 'package:uuid/uuid.dart';

abstract class Helpers {
  static String generateId() => Uuid().v4();
}
