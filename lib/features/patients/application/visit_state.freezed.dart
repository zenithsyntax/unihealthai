// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VisitState {
  bool get isLoading;
  List<VisitEntity> get visits;
  Option<Failure> get failureOrSuccessOption;

  /// Create a copy of VisitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VisitStateCopyWith<VisitState> get copyWith =>
      _$VisitStateCopyWithImpl<VisitState>(this as VisitState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VisitState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other.visits, visits) &&
            (identical(other.failureOrSuccessOption, failureOrSuccessOption) ||
                other.failureOrSuccessOption == failureOrSuccessOption));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(visits), failureOrSuccessOption);

  @override
  String toString() {
    return 'VisitState(isLoading: $isLoading, visits: $visits, failureOrSuccessOption: $failureOrSuccessOption)';
  }
}

/// @nodoc
abstract mixin class $VisitStateCopyWith<$Res> {
  factory $VisitStateCopyWith(
          VisitState value, $Res Function(VisitState) _then) =
      _$VisitStateCopyWithImpl;
  @useResult
  $Res call(
      {bool isLoading,
      List<VisitEntity> visits,
      Option<Failure> failureOrSuccessOption});
}

/// @nodoc
class _$VisitStateCopyWithImpl<$Res> implements $VisitStateCopyWith<$Res> {
  _$VisitStateCopyWithImpl(this._self, this._then);

  final VisitState _self;
  final $Res Function(VisitState) _then;

  /// Create a copy of VisitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? visits = null,
    Object? failureOrSuccessOption = null,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      visits: null == visits
          ? _self.visits
          : visits // ignore: cast_nullable_to_non_nullable
              as List<VisitEntity>,
      failureOrSuccessOption: null == failureOrSuccessOption
          ? _self.failureOrSuccessOption
          : failureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Failure>,
    ));
  }
}

/// Adds pattern-matching-related methods to [VisitState].
extension VisitStatePatterns on VisitState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_VisitState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VisitState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_VisitState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VisitState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_VisitState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VisitState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(bool isLoading, List<VisitEntity> visits,
            Option<Failure> failureOrSuccessOption)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VisitState() when $default != null:
        return $default(
            _that.isLoading, _that.visits, _that.failureOrSuccessOption);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(bool isLoading, List<VisitEntity> visits,
            Option<Failure> failureOrSuccessOption)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VisitState():
        return $default(
            _that.isLoading, _that.visits, _that.failureOrSuccessOption);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(bool isLoading, List<VisitEntity> visits,
            Option<Failure> failureOrSuccessOption)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VisitState() when $default != null:
        return $default(
            _that.isLoading, _that.visits, _that.failureOrSuccessOption);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VisitState implements VisitState {
  const _VisitState(
      {this.isLoading = false,
      final List<VisitEntity> visits = const [],
      this.failureOrSuccessOption = const None()})
      : _visits = visits;

  @override
  @JsonKey()
  final bool isLoading;
  final List<VisitEntity> _visits;
  @override
  @JsonKey()
  List<VisitEntity> get visits {
    if (_visits is EqualUnmodifiableListView) return _visits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visits);
  }

  @override
  @JsonKey()
  final Option<Failure> failureOrSuccessOption;

  /// Create a copy of VisitState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VisitStateCopyWith<_VisitState> get copyWith =>
      __$VisitStateCopyWithImpl<_VisitState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VisitState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._visits, _visits) &&
            (identical(other.failureOrSuccessOption, failureOrSuccessOption) ||
                other.failureOrSuccessOption == failureOrSuccessOption));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_visits), failureOrSuccessOption);

  @override
  String toString() {
    return 'VisitState(isLoading: $isLoading, visits: $visits, failureOrSuccessOption: $failureOrSuccessOption)';
  }
}

/// @nodoc
abstract mixin class _$VisitStateCopyWith<$Res>
    implements $VisitStateCopyWith<$Res> {
  factory _$VisitStateCopyWith(
          _VisitState value, $Res Function(_VisitState) _then) =
      __$VisitStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<VisitEntity> visits,
      Option<Failure> failureOrSuccessOption});
}

/// @nodoc
class __$VisitStateCopyWithImpl<$Res> implements _$VisitStateCopyWith<$Res> {
  __$VisitStateCopyWithImpl(this._self, this._then);

  final _VisitState _self;
  final $Res Function(_VisitState) _then;

  /// Create a copy of VisitState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? visits = null,
    Object? failureOrSuccessOption = null,
  }) {
    return _then(_VisitState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      visits: null == visits
          ? _self._visits
          : visits // ignore: cast_nullable_to_non_nullable
              as List<VisitEntity>,
      failureOrSuccessOption: null == failureOrSuccessOption
          ? _self.failureOrSuccessOption
          : failureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Failure>,
    ));
  }
}

// dart format on
