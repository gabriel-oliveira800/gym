import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ModalKey { none, addExercise, addTraining }

final modalProvider = StateProvider<ModalKey>((ref) => ModalKey.none);
