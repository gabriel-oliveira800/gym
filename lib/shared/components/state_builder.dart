import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/failure/failure.dart';
import '../state/default_state.dart';
import 'bg_container.dart';
import 'bg_loading.dart';

class StateBuilder<T> extends StatelessWidget {
  final ValueListenable<DefaultState<T>> listenable;
  final WidgetBuilder? initial;
  final WidgetBuilder? loading;
  final Widget Function(BuildContext context, T data) success;
  final Widget Function(BuildContext context, Failure failure)? error;

  const StateBuilder({
    super.key,
    required this.listenable,
    required this.success,
    this.initial,
    this.loading,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DefaultState<T>>(
      valueListenable: listenable,
      builder: (context, state, _) {
        return state.when<Widget>(
          initial: () => initial?.call(context) ?? loading?.call(context) ?? const BgLoading(),
          loading: () => loading?.call(context) ?? const BgLoading(),
          success: (data) => success(context, data),
          error: (failure) =>
              error?.call(context, failure) ??
              BgContainer(
                child: Center(
                  child: Text(
                    'Erro: ${failure.message}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
        );
      },
    );
  }
}
