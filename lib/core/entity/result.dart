import '../failure/failure.dart';

sealed class Result<T> {
  const Result();

  const factory Result.success(T value) = Success<T>;
  const factory Result.failure(Failure failure) = Error<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Error<T>;

  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(Failure failure) onFailure,
  }) {
    final self = this;
    if (self is Success<T>) return onSuccess(self.value);
    return onFailure((self as Error<T>).failure);
  }

  T? getValueOrNull() {
    final self = this;
    if (self is Success<T>) return self.value;
    return null;
  }

  Failure? getFailureOrNull() {
    final self = this;
    if (self is Error<T>) return self.failure;
    return null;
  }
}

final class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

final class Error<T> extends Result<T> {
  final Failure failure;
  const Error(this.failure);
}
