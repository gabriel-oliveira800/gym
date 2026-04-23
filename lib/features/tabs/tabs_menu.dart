import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../shared/index.dart';

import 'components/bottom_navigation.dart';
import 'components/tab_header.dart';

class TabsMenu extends StatelessWidget {
  final Widget child;
  const TabsMenu({super.key, required this.child});

  int _getCurrentIndex(BuildContext context) {
    return AllRoutes.fromRoute(GoRouterState.of(context).fullPath).index;
  }

  void _onNavItemSelected(int index) {
    final selectedTab = AllRoutes.values[index];
    AppNavigation.tabNavigation(selectedTab);
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _getCurrentIndex(context);

    return Scaffold(
      body: child,
      appBar: const TabHeader(),
      backgroundColor: AppColors.background,
      bottomNavigationBar: BottomNavigation(
        selectedIndex: selectedIndex,
        onItemSelected: _onNavItemSelected,
      ),
    );
  }
}
