import 'package:flutter/material.dart';

class VisibleArea extends StatelessWidget {
  final bool visible;
  final Widget child;
  final Widget? placeholder;

  const VisibleArea({
    super.key,
    required this.visible,
    required this.child,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    if (visible) return child;
    return placeholder ?? const SizedBox.shrink();
  }
}
