import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/index.dart';
import 'routes.dart';

abstract class AppNavigation {
  static final _key = GlobalKey<NavigatorState>();

  static void tabNavigation(AllRoutes tab) => routes.go(tab.path);

  static void toTrainingDetail(String id) {
    routes.push(AllRoutes.trainingDetailPath(id));
  }

  static void toHome() => routes.pushReplacement(AllRoutes.home.path);

  static void back() {
    if (routes.canPop()) {
      routes.pop();
    } else {
      routes.go(AllRoutes.home.path);
    }
  }

  static GoRouter routes = GoRouter(
    navigatorKey: _key,
    initialLocation: AllRoutes.home.path,
    routes: [
      ShellRoute(
        builder: (context, state, child) => TabsMenu(child: child),
        routes: [
          GoRoute(
            path: AllRoutes.home.path,
            builder: (_, __) => const HomeScreen(),
          ),
          GoRoute(
            path: AllRoutes.exercises.path,
            builder: (context, state) => const ExercisesScreen(),
          ),
          GoRoute(
            path: AllRoutes.segments.path,
            builder: (context, state) => const SegmentsScreen(),
          ),
          GoRoute(
            path: AllRoutes.stats.path,
            builder: (context, state) => const StatsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AllRoutes.trainingDetail.path,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return TrainingDetailScreen(id: id);
        },
      ),
    ],
  );
}
