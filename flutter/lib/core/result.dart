/// A type that represents either a success with a value or a failure with an error.
/// This follows functional programming best practices for error handling.
class Result<T> {
  final T? _value;
  final Object? _error;
  final bool _isSuccess;

  const Result._(this._value, this._error, this._isSuccess);

  /// Creates a successful result with the given value.
  factory Result.success(T value) {
    return Result._(value, null, true);
  }

  /// Creates a failed result with the given error.
  factory Result.failure(Object error) {
    return Result._(null, error, false);
  }

  /// Returns true if this result is a success.
  bool get isSuccess => _isSuccess;

  /// Returns true if this result is a failure.
  bool get isFailure => !_isSuccess;

  /// Returns the value if this is a success, otherwise throws the error.
  T get value {
    if (_isSuccess) {
      return _value as T;
    }
    throw _error!;
  }

  /// Returns the value if this is a success, otherwise returns the provided default.
  T getOrElse(T defaultValue) {
    return _isSuccess ? (_value as T) : defaultValue;
  }

  /// Returns the error if this is a failure, otherwise returns null.
  Object? get error => _error;

  /// Executes the provided function if this is a success.
  Result<T> onSuccess(void Function(T value) action) {
    if (_isSuccess) {
      action(_value as T);
    }
    return this;
  }

  /// Executes the provided function if this is a failure.
  Result<T> onFailure(void Function(Object error) action) {
    if (!_isSuccess) {
      action(_error!);
    }
    return this;
  }

  /// Transforms the value if this is a success using the provided function.
  Result<R> map<R>(R Function(T value) transform) {
    if (_isSuccess) {
      try {
        return Result.success(transform(_value as T));
      } catch (e) {
        return Result.failure(e);
      }
    }
    return Result.failure(_error!);
  }

  /// Returns the result of the provided function if this is a success,
  /// otherwise returns this failure.
  Result<R> flatMap<R>(Result<R> Function(T value) transform) {
    if (_isSuccess) {
      try {
        return transform(_value as T);
      } catch (e) {
        return Result.failure(e);
      }
    }
    return Result.failure(_error!);
  }

  /// Transforms the error if this is a failure using the provided function.
  Result<T> mapError(Object Function(Object error) transform) {
    if (!_isSuccess) {
      try {
        return Result.failure(transform(_error!));
      } catch (e) {
        return Result.failure(e);
      }
    }
    return Result.success(_value as T);
  }

  /// Recovers from a failure by providing a fallback result.
  Result<T> recover(Result<T> Function(Object error) fallback) {
    if (!_isSuccess) {
      try {
        return fallback(_error!);
      } catch (e) {
        return Result.failure(e);
      }
    }
    return this;
  }

  /// Folds the result by applying the appropriate function.
  R fold<R>(
    R Function(T value) onSuccess,
    R Function(Object error) onFailure,
  ) {
    if (_isSuccess) {
      return onSuccess(_value as T);
    }
    return onFailure(_error!);
  }

  /// Returns a new result with the value transformed if success, or error if failure.
  Result<R> andThen<R>(Result<R> Function(T value) transform) {
    return flatMap(transform);
  }

  /// Returns a new result with the error transformed if failure, or value if success.
  Result<T> orElse(Result<T> Function(Object error) fallback) {
    return recover(fallback);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Result<T> &&
        other._isSuccess == _isSuccess &&
        other._value == _value &&
        other._error == _error;
  }

  @override
  int get hashCode => Object.hash(_value, _error, _isSuccess);

  @override
  String toString() {
    if (_isSuccess) {
      return 'Result.success($_value)';
    }
    return 'Result.failure($_error)';
  }
}
