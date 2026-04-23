enum AllRoutes {
  home('/home'),
  exercises('/exercises'),
  segments('/segments'),
  stats('/stats');

  final String path;
  const AllRoutes(this.path);

  factory AllRoutes.fromRoute(String? route) {
    return AllRoutes.values.firstWhere(
      orElse: () => AllRoutes.home,
      (tab) => tab.path.contains(route ?? ''),
    );
  }
}
