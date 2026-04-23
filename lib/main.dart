import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'shared/index.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Binds().setup();
  runApp(const ProviderScope(child: GymApp()));
}
