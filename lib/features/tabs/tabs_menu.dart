import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../shared/index.dart';
import 'components/index.dart';
import 'tabs_controller.dart';

class TabsMenu extends StatefulWidget {
  final Widget child;
  const TabsMenu({super.key, required this.child});

  @override
  State<TabsMenu> createState() => _TabsMenuState();
}

class _TabsMenuState extends State<TabsMenu> {
  final TabsController _controller = Binds().get<TabsController>();

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _controller.indexForRoute(GoRouterState.of(context).fullPath);

    return Scaffold(
      body: widget.child,
      appBar: const TabHeader(),
      backgroundColor: AppColors.background,
      bottomNavigationBar: BottomNavigation(
        selectedIndex: selectedIndex,
        onItemSelected: _controller.onItemSelected,
      ),
    );
  }
}
