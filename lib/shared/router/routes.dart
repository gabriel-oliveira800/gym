enum AllRoutes {
  home('/home'),
  exercises('/exercises'),
  segments('/segments'),
  stats('/stats'),
  trainingDetail('/training/:id');

  final String path;
  const AllRoutes(this.path);

  factory AllRoutes.fromRoute(String? route) {
    return AllRoutes.values.firstWhere(
      orElse: () => AllRoutes.home,
      (tab) => !tab.path.contains(':') && tab.path.contains(route ?? ''),
    );
  }

  static String trainingDetailPath(String id) => '/training/$id';
}
