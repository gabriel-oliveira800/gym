import 'package:flutter/foundation.dart';

import '../../shared/state/default_state.dart';

class StatsController extends ValueNotifier<DefaultState<void>> {
  StatsController() : super(const InitialState<void>());
}
