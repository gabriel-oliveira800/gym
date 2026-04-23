import 'package:flutter/material.dart';

import 'shared/binds.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Binds().setup();
  runApp(const GymApp());
}
