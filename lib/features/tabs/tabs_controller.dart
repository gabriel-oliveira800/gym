import 'package:flutter/foundation.dart';

import '../../shared/router/navigation.dart';
import '../../shared/router/routes.dart';

class TabsController extends ValueNotifier<int> {
  TabsController() : super(0);

  int indexForRoute(String? fullPath) {
    return AllRoutes.fromRoute(fullPath).index;
  }

  void onItemSelected(int index) {
    final selectedTab = AllRoutes.values[index];
    value = index;
    AppNavigation.tabNavigation(selectedTab);
  }
}
