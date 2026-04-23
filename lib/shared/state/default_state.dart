import '../../core/failure/failure.dart';

sealed class DefaultState<T> {
  const DefaultState();
}

final class InitialState<T> extends DefaultState<T> {
  const InitialState();
}

final class LoadingState<T> extends DefaultState<T> {
  const LoadingState();
}

final class SuccessState<T> extends DefaultState<T> {
  final T data;
  const SuccessState(this.data);
}

final class ErrorState<T> extends DefaultState<T> {
  final Failure failure;
  const ErrorState(this.failure);
}

extension DefaultStateX<T> on DefaultState<T> {
  bool get isInitial => this is InitialState<T>;
  bool get isLoading => this is LoadingState<T>;
  bool get isSuccess => this is SuccessState<T>;
  bool get isError => this is ErrorState<T>;

  T? get dataOrNull {
    final self = this;
    if (self is SuccessState<T>) return self.data;
    return null;
  }

  Failure? get failureOrNull {
    final self = this;
    if (self is ErrorState<T>) return self.failure;
    return null;
  }

  R when<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(Failure failure)? error,
    R Function()? orElse,
  }) {
    final self = this;
    if (self is InitialState<T> && initial != null) return initial();
    if (self is LoadingState<T> && loading != null) return loading();
    if (self is SuccessState<T> && success != null) return success(self.data);
    if (self is ErrorState<T> && error != null) return error(self.failure);
    if (orElse != null) return orElse();
    throw StateError('Unhandled state: $self');
  }

  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(Failure failure)? error,
    required R Function() orElse,
  }) {
    return when<R>(
      initial: initial,
      loading: loading,
      success: success,
      error: error,
      orElse: orElse,
    );
  }
}
