import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../index.dart';
import '../../features/index.dart';
import '../../features/home/home_screen.dart';
import '../../features/exercises/exercises_screen.dart';
import '../../features/segments/segments_screen.dart';
import '../../features/stats/stats_screen.dart';

abstract class AppNavigation {
  static final _key = GlobalKey<NavigatorState>();

  static void tabNavigation(AllRoutes tab) => routes.go(tab.path);

  static GoRouter get config => routes;
}

final GoRouter routes = GoRouter(
  navigatorKey: AppNavigation._key,
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
  ],
);
