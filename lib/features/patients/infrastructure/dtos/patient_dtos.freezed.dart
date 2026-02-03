// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PatientDto {
  String? get id;
  String get doctorId;
  String get name;
  int get age;
  String get gender;
  String get contactNumber;
  List<VisitDto> get visits;

  /// Create a copy of PatientDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PatientDtoCopyWith<PatientDto> get copyWith =>
      _$PatientDtoCopyWithImpl<PatientDto>(this as PatientDto, _$identity);

  /// Serializes this PatientDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PatientDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.contactNumber, contactNumber) ||
                other.contactNumber == contactNumber) &&
            const DeepCollectionEquality().equals(other.visits, visits));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, doctorId, name, age, gender,
      contactNumber, const DeepCollectionEquality().hash(visits));

  @override
  String toString() {
    return 'PatientDto(id: $id, doctorId: $doctorId, name: $name, age: $age, gender: $gender, contactNumber: $contactNumber, visits: $visits)';
  }
}

/// @nodoc
abstract mixin class $PatientDtoCopyWith<$Res> {
  factory $PatientDtoCopyWith(
          PatientDto value, $Res Function(PatientDto) _then) =
      _$PatientDtoCopyWithImpl;
  @useResult
  $Res call(
      {String? id,
      String doctorId,
      String name,
      int age,
      String gender,
      String contactNumber,
      List<VisitDto> visits});
}

/// @nodoc
class _$PatientDtoCopyWithImpl<$Res> implements $PatientDtoCopyWith<$Res> {
  _$PatientDtoCopyWithImpl(this._self, this._then);

  final PatientDto _self;
  final $Res Function(PatientDto) _then;

  /// Create a copy of PatientDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? doctorId = null,
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? contactNumber = null,
    Object? visits = null,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorId: null == doctorId
          ? _self.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: null == contactNumber
          ? _self.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      visits: null == visits
          ? _self.visits
          : visits // ignore: cast_nullable_to_non_nullable
              as List<VisitDto>,
    ));
  }
}

/// Adds pattern-matching-related methods to [PatientDto].
extension PatientDtoPatterns on PatientDto {
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
    TResult Function(_PatientDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PatientDto() when $default != null:
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
    TResult Function(_PatientDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatientDto():
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
    TResult? Function(_PatientDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatientDto() when $default != null:
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
    TResult Function(String? id, String doctorId, String name, int age,
            String gender, String contactNumber, List<VisitDto> visits)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PatientDto() when $default != null:
        return $default(_that.id, _that.doctorId, _that.name, _that.age,
            _that.gender, _that.contactNumber, _that.visits);
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
    TResult Function(String? id, String doctorId, String name, int age,
            String gender, String contactNumber, List<VisitDto> visits)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatientDto():
        return $default(_that.id, _that.doctorId, _that.name, _that.age,
            _that.gender, _that.contactNumber, _that.visits);
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
    TResult? Function(String? id, String doctorId, String name, int age,
            String gender, String contactNumber, List<VisitDto> visits)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatientDto() when $default != null:
        return $default(_that.id, _that.doctorId, _that.name, _that.age,
            _that.gender, _that.contactNumber, _that.visits);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PatientDto extends PatientDto {
  const _PatientDto(
      {this.id,
      required this.doctorId,
      required this.name,
      required this.age,
      required this.gender,
      required this.contactNumber,
      final List<VisitDto> visits = const []})
      : _visits = visits,
        super._();
  factory _PatientDto.fromJson(Map<String, dynamic> json) =>
      _$PatientDtoFromJson(json);

  @override
  final String? id;
  @override
  final String doctorId;
  @override
  final String name;
  @override
  final int age;
  @override
  final String gender;
  @override
  final String contactNumber;
  final List<VisitDto> _visits;
  @override
  @JsonKey()
  List<VisitDto> get visits {
    if (_visits is EqualUnmodifiableListView) return _visits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visits);
  }

  /// Create a copy of PatientDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PatientDtoCopyWith<_PatientDto> get copyWith =>
      __$PatientDtoCopyWithImpl<_PatientDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PatientDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PatientDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.contactNumber, contactNumber) ||
                other.contactNumber == contactNumber) &&
            const DeepCollectionEquality().equals(other._visits, _visits));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, doctorId, name, age, gender,
      contactNumber, const DeepCollectionEquality().hash(_visits));

  @override
  String toString() {
    return 'PatientDto(id: $id, doctorId: $doctorId, name: $name, age: $age, gender: $gender, contactNumber: $contactNumber, visits: $visits)';
  }
}

/// @nodoc
abstract mixin class _$PatientDtoCopyWith<$Res>
    implements $PatientDtoCopyWith<$Res> {
  factory _$PatientDtoCopyWith(
          _PatientDto value, $Res Function(_PatientDto) _then) =
      __$PatientDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String doctorId,
      String name,
      int age,
      String gender,
      String contactNumber,
      List<VisitDto> visits});
}

/// @nodoc
class __$PatientDtoCopyWithImpl<$Res> implements _$PatientDtoCopyWith<$Res> {
  __$PatientDtoCopyWithImpl(this._self, this._then);

  final _PatientDto _self;
  final $Res Function(_PatientDto) _then;

  /// Create a copy of PatientDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? doctorId = null,
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? contactNumber = null,
    Object? visits = null,
  }) {
    return _then(_PatientDto(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorId: null == doctorId
          ? _self.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: null == contactNumber
          ? _self.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      visits: null == visits
          ? _self._visits
          : visits // ignore: cast_nullable_to_non_nullable
              as List<VisitDto>,
    ));
  }
}

/// @nodoc
mixin _$VisitDto {
  String get id;
  DateTime get date;
  String get assessment;
  String get diagnosis;
  String get prescription;
  String? get notes;
  List<MedicalReportDto> get reports;

  /// Create a copy of VisitDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VisitDtoCopyWith<VisitDto> get copyWith =>
      _$VisitDtoCopyWithImpl<VisitDto>(this as VisitDto, _$identity);

  /// Serializes this VisitDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VisitDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.assessment, assessment) ||
                other.assessment == assessment) &&
            (identical(other.diagnosis, diagnosis) ||
                other.diagnosis == diagnosis) &&
            (identical(other.prescription, prescription) ||
                other.prescription == prescription) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other.reports, reports));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, assessment, diagnosis,
      prescription, notes, const DeepCollectionEquality().hash(reports));

  @override
  String toString() {
    return 'VisitDto(id: $id, date: $date, assessment: $assessment, diagnosis: $diagnosis, prescription: $prescription, notes: $notes, reports: $reports)';
  }
}

/// @nodoc
abstract mixin class $VisitDtoCopyWith<$Res> {
  factory $VisitDtoCopyWith(VisitDto value, $Res Function(VisitDto) _then) =
      _$VisitDtoCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      DateTime date,
      String assessment,
      String diagnosis,
      String prescription,
      String? notes,
      List<MedicalReportDto> reports});
}

/// @nodoc
class _$VisitDtoCopyWithImpl<$Res> implements $VisitDtoCopyWith<$Res> {
  _$VisitDtoCopyWithImpl(this._self, this._then);

  final VisitDto _self;
  final $Res Function(VisitDto) _then;

  /// Create a copy of VisitDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? assessment = null,
    Object? diagnosis = null,
    Object? prescription = null,
    Object? notes = freezed,
    Object? reports = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      assessment: null == assessment
          ? _self.assessment
          : assessment // ignore: cast_nullable_to_non_nullable
              as String,
      diagnosis: null == diagnosis
          ? _self.diagnosis
          : diagnosis // ignore: cast_nullable_to_non_nullable
              as String,
      prescription: null == prescription
          ? _self.prescription
          : prescription // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      reports: null == reports
          ? _self.reports
          : reports // ignore: cast_nullable_to_non_nullable
              as List<MedicalReportDto>,
    ));
  }
}

/// Adds pattern-matching-related methods to [VisitDto].
extension VisitDtoPatterns on VisitDto {
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
    TResult Function(_VisitDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VisitDto() when $default != null:
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
    TResult Function(_VisitDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VisitDto():
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
    TResult? Function(_VisitDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VisitDto() when $default != null:
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
    TResult Function(
            String id,
            DateTime date,
            String assessment,
            String diagnosis,
            String prescription,
            String? notes,
            List<MedicalReportDto> reports)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VisitDto() when $default != null:
        return $default(_that.id, _that.date, _that.assessment, _that.diagnosis,
            _that.prescription, _that.notes, _that.reports);
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
    TResult Function(
            String id,
            DateTime date,
            String assessment,
            String diagnosis,
            String prescription,
            String? notes,
            List<MedicalReportDto> reports)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VisitDto():
        return $default(_that.id, _that.date, _that.assessment, _that.diagnosis,
            _that.prescription, _that.notes, _that.reports);
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
    TResult? Function(
            String id,
            DateTime date,
            String assessment,
            String diagnosis,
            String prescription,
            String? notes,
            List<MedicalReportDto> reports)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VisitDto() when $default != null:
        return $default(_that.id, _that.date, _that.assessment, _that.diagnosis,
            _that.prescription, _that.notes, _that.reports);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _VisitDto extends VisitDto {
  const _VisitDto(
      {required this.id,
      required this.date,
      required this.assessment,
      required this.diagnosis,
      required this.prescription,
      this.notes,
      final List<MedicalReportDto> reports = const []})
      : _reports = reports,
        super._();
  factory _VisitDto.fromJson(Map<String, dynamic> json) =>
      _$VisitDtoFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final String assessment;
  @override
  final String diagnosis;
  @override
  final String prescription;
  @override
  final String? notes;
  final List<MedicalReportDto> _reports;
  @override
  @JsonKey()
  List<MedicalReportDto> get reports {
    if (_reports is EqualUnmodifiableListView) return _reports;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reports);
  }

  /// Create a copy of VisitDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VisitDtoCopyWith<_VisitDto> get copyWith =>
      __$VisitDtoCopyWithImpl<_VisitDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VisitDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VisitDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.assessment, assessment) ||
                other.assessment == assessment) &&
            (identical(other.diagnosis, diagnosis) ||
                other.diagnosis == diagnosis) &&
            (identical(other.prescription, prescription) ||
                other.prescription == prescription) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._reports, _reports));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, assessment, diagnosis,
      prescription, notes, const DeepCollectionEquality().hash(_reports));

  @override
  String toString() {
    return 'VisitDto(id: $id, date: $date, assessment: $assessment, diagnosis: $diagnosis, prescription: $prescription, notes: $notes, reports: $reports)';
  }
}

/// @nodoc
abstract mixin class _$VisitDtoCopyWith<$Res>
    implements $VisitDtoCopyWith<$Res> {
  factory _$VisitDtoCopyWith(_VisitDto value, $Res Function(_VisitDto) _then) =
      __$VisitDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime date,
      String assessment,
      String diagnosis,
      String prescription,
      String? notes,
      List<MedicalReportDto> reports});
}

/// @nodoc
class __$VisitDtoCopyWithImpl<$Res> implements _$VisitDtoCopyWith<$Res> {
  __$VisitDtoCopyWithImpl(this._self, this._then);

  final _VisitDto _self;
  final $Res Function(_VisitDto) _then;

  /// Create a copy of VisitDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? assessment = null,
    Object? diagnosis = null,
    Object? prescription = null,
    Object? notes = freezed,
    Object? reports = null,
  }) {
    return _then(_VisitDto(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      assessment: null == assessment
          ? _self.assessment
          : assessment // ignore: cast_nullable_to_non_nullable
              as String,
      diagnosis: null == diagnosis
          ? _self.diagnosis
          : diagnosis // ignore: cast_nullable_to_non_nullable
              as String,
      prescription: null == prescription
          ? _self.prescription
          : prescription // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      reports: null == reports
          ? _self._reports
          : reports // ignore: cast_nullable_to_non_nullable
              as List<MedicalReportDto>,
    ));
  }
}

/// @nodoc
mixin _$MedicalReportDto {
  String get id;
  String get name;
  String get fileUrl;
  DateTime get date;
  String get type;

  /// Create a copy of MedicalReportDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedicalReportDtoCopyWith<MedicalReportDto> get copyWith =>
      _$MedicalReportDtoCopyWithImpl<MedicalReportDto>(
          this as MedicalReportDto, _$identity);

  /// Serializes this MedicalReportDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedicalReportDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, fileUrl, date, type);

  @override
  String toString() {
    return 'MedicalReportDto(id: $id, name: $name, fileUrl: $fileUrl, date: $date, type: $type)';
  }
}

/// @nodoc
abstract mixin class $MedicalReportDtoCopyWith<$Res> {
  factory $MedicalReportDtoCopyWith(
          MedicalReportDto value, $Res Function(MedicalReportDto) _then) =
      _$MedicalReportDtoCopyWithImpl;
  @useResult
  $Res call(
      {String id, String name, String fileUrl, DateTime date, String type});
}

/// @nodoc
class _$MedicalReportDtoCopyWithImpl<$Res>
    implements $MedicalReportDtoCopyWith<$Res> {
  _$MedicalReportDtoCopyWithImpl(this._self, this._then);

  final MedicalReportDto _self;
  final $Res Function(MedicalReportDto) _then;

  /// Create a copy of MedicalReportDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fileUrl = null,
    Object? date = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fileUrl: null == fileUrl
          ? _self.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [MedicalReportDto].
extension MedicalReportDtoPatterns on MedicalReportDto {
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
    TResult Function(_MedicalReportDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MedicalReportDto() when $default != null:
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
    TResult Function(_MedicalReportDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicalReportDto():
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
    TResult? Function(_MedicalReportDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicalReportDto() when $default != null:
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
    TResult Function(
            String id, String name, String fileUrl, DateTime date, String type)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MedicalReportDto() when $default != null:
        return $default(
            _that.id, _that.name, _that.fileUrl, _that.date, _that.type);
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
    TResult Function(
            String id, String name, String fileUrl, DateTime date, String type)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicalReportDto():
        return $default(
            _that.id, _that.name, _that.fileUrl, _that.date, _that.type);
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
    TResult? Function(
            String id, String name, String fileUrl, DateTime date, String type)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicalReportDto() when $default != null:
        return $default(
            _that.id, _that.name, _that.fileUrl, _that.date, _that.type);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MedicalReportDto extends MedicalReportDto {
  const _MedicalReportDto(
      {required this.id,
      required this.name,
      required this.fileUrl,
      required this.date,
      required this.type})
      : super._();
  factory _MedicalReportDto.fromJson(Map<String, dynamic> json) =>
      _$MedicalReportDtoFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String fileUrl;
  @override
  final DateTime date;
  @override
  final String type;

  /// Create a copy of MedicalReportDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MedicalReportDtoCopyWith<_MedicalReportDto> get copyWith =>
      __$MedicalReportDtoCopyWithImpl<_MedicalReportDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MedicalReportDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MedicalReportDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, fileUrl, date, type);

  @override
  String toString() {
    return 'MedicalReportDto(id: $id, name: $name, fileUrl: $fileUrl, date: $date, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$MedicalReportDtoCopyWith<$Res>
    implements $MedicalReportDtoCopyWith<$Res> {
  factory _$MedicalReportDtoCopyWith(
          _MedicalReportDto value, $Res Function(_MedicalReportDto) _then) =
      __$MedicalReportDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id, String name, String fileUrl, DateTime date, String type});
}

/// @nodoc
class __$MedicalReportDtoCopyWithImpl<$Res>
    implements _$MedicalReportDtoCopyWith<$Res> {
  __$MedicalReportDtoCopyWithImpl(this._self, this._then);

  final _MedicalReportDto _self;
  final $Res Function(_MedicalReportDto) _then;

  /// Create a copy of MedicalReportDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fileUrl = null,
    Object? date = null,
    Object? type = null,
  }) {
    return _then(_MedicalReportDto(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fileUrl: null == fileUrl
          ? _self.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
