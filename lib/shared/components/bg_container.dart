import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BgContainer extends StatelessWidget {
  final Widget child;

  const BgContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: child,
        ),
      ),
    );
  }
}
