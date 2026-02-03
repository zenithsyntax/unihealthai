// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PatientEntity {
  String get id;
  String get doctorId;
  String get name;
  int get age;
  String get gender;
  String get contactNumber;
  List<VisitEntity> get visits;

  /// Create a copy of PatientEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PatientEntityCopyWith<PatientEntity> get copyWith =>
      _$PatientEntityCopyWithImpl<PatientEntity>(
          this as PatientEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PatientEntity &&
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

  @override
  int get hashCode => Object.hash(runtimeType, id, doctorId, name, age, gender,
      contactNumber, const DeepCollectionEquality().hash(visits));

  @override
  String toString() {
    return 'PatientEntity(id: $id, doctorId: $doctorId, name: $name, age: $age, gender: $gender, contactNumber: $contactNumber, visits: $visits)';
  }
}

/// @nodoc
abstract mixin class $PatientEntityCopyWith<$Res> {
  factory $PatientEntityCopyWith(
          PatientEntity value, $Res Function(PatientEntity) _then) =
      _$PatientEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String doctorId,
      String name,
      int age,
      String gender,
      String contactNumber,
      List<VisitEntity> visits});
}

/// @nodoc
class _$PatientEntityCopyWithImpl<$Res>
    implements $PatientEntityCopyWith<$Res> {
  _$PatientEntityCopyWithImpl(this._self, this._then);

  final PatientEntity _self;
  final $Res Function(PatientEntity) _then;

  /// Create a copy of PatientEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? doctorId = null,
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? contactNumber = null,
    Object? visits = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
              as List<VisitEntity>,
    ));
  }
}

/// Adds pattern-matching-related methods to [PatientEntity].
extension PatientEntityPatterns on PatientEntity {
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
    TResult Function(_PatientEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PatientEntity() when $default != null:
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
    TResult Function(_PatientEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatientEntity():
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
    TResult? Function(_PatientEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatientEntity() when $default != null:
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
    TResult Function(String id, String doctorId, String name, int age,
            String gender, String contactNumber, List<VisitEntity> visits)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PatientEntity() when $default != null:
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
    TResult Function(String id, String doctorId, String name, int age,
            String gender, String contactNumber, List<VisitEntity> visits)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatientEntity():
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
    TResult? Function(String id, String doctorId, String name, int age,
            String gender, String contactNumber, List<VisitEntity> visits)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatientEntity() when $default != null:
        return $default(_that.id, _that.doctorId, _that.name, _that.age,
            _that.gender, _that.contactNumber, _that.visits);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PatientEntity implements PatientEntity {
  const _PatientEntity(
      {required this.id,
      required this.doctorId,
      required this.name,
      required this.age,
      required this.gender,
      required this.contactNumber,
      final List<VisitEntity> visits = const []})
      : _visits = visits;

  @override
  final String id;
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
  final List<VisitEntity> _visits;
  @override
  @JsonKey()
  List<VisitEntity> get visits {
    if (_visits is EqualUnmodifiableListView) return _visits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visits);
  }

  /// Create a copy of PatientEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PatientEntityCopyWith<_PatientEntity> get copyWith =>
      __$PatientEntityCopyWithImpl<_PatientEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PatientEntity &&
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

  @override
  int get hashCode => Object.hash(runtimeType, id, doctorId, name, age, gender,
      contactNumber, const DeepCollectionEquality().hash(_visits));

  @override
  String toString() {
    return 'PatientEntity(id: $id, doctorId: $doctorId, name: $name, age: $age, gender: $gender, contactNumber: $contactNumber, visits: $visits)';
  }
}

/// @nodoc
abstract mixin class _$PatientEntityCopyWith<$Res>
    implements $PatientEntityCopyWith<$Res> {
  factory _$PatientEntityCopyWith(
          _PatientEntity value, $Res Function(_PatientEntity) _then) =
      __$PatientEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String doctorId,
      String name,
      int age,
      String gender,
      String contactNumber,
      List<VisitEntity> visits});
}

/// @nodoc
class __$PatientEntityCopyWithImpl<$Res>
    implements _$PatientEntityCopyWith<$Res> {
  __$PatientEntityCopyWithImpl(this._self, this._then);

  final _PatientEntity _self;
  final $Res Function(_PatientEntity) _then;

  /// Create a copy of PatientEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? doctorId = null,
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? contactNumber = null,
    Object? visits = null,
  }) {
    return _then(_PatientEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
              as List<VisitEntity>,
    ));
  }
}

/// @nodoc
mixin _$VisitEntity {
  String get id;
  DateTime get date;
  String get assessment;
  String get diagnosis;
  String get prescription;
  String? get notes;
  List<MedicalReportEntity> get reports;

  /// Create a copy of VisitEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VisitEntityCopyWith<VisitEntity> get copyWith =>
      _$VisitEntityCopyWithImpl<VisitEntity>(this as VisitEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VisitEntity &&
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

  @override
  int get hashCode => Object.hash(runtimeType, id, date, assessment, diagnosis,
      prescription, notes, const DeepCollectionEquality().hash(reports));

  @override
  String toString() {
    return 'VisitEntity(id: $id, date: $date, assessment: $assessment, diagnosis: $diagnosis, prescription: $prescription, notes: $notes, reports: $reports)';
  }
}

/// @nodoc
abstract mixin class $VisitEntityCopyWith<$Res> {
  factory $VisitEntityCopyWith(
          VisitEntity value, $Res Function(VisitEntity) _then) =
      _$VisitEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      DateTime date,
      String assessment,
      String diagnosis,
      String prescription,
      String? notes,
      List<MedicalReportEntity> reports});
}

/// @nodoc
class _$VisitEntityCopyWithImpl<$Res> implements $VisitEntityCopyWith<$Res> {
  _$VisitEntityCopyWithImpl(this._self, this._then);

  final VisitEntity _self;
  final $Res Function(VisitEntity) _then;

  /// Create a copy of VisitEntity
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
              as List<MedicalReportEntity>,
    ));
  }
}

/// Adds pattern-matching-related methods to [VisitEntity].
extension VisitEntityPatterns on VisitEntity {
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
    TResult Function(_VisitEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VisitEntity() when $default != null:
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
    TResult Function(_VisitEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VisitEntity():
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
    TResult? Function(_VisitEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VisitEntity() when $default != null:
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
            List<MedicalReportEntity> reports)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VisitEntity() when $default != null:
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
            List<MedicalReportEntity> reports)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VisitEntity():
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
            List<MedicalReportEntity> reports)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VisitEntity() when $default != null:
        return $default(_that.id, _that.date, _that.assessment, _that.diagnosis,
            _that.prescription, _that.notes, _that.reports);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VisitEntity implements VisitEntity {
  const _VisitEntity(
      {required this.id,
      required this.date,
      required this.assessment,
      required this.diagnosis,
      required this.prescription,
      this.notes,
      final List<MedicalReportEntity> reports = const []})
      : _reports = reports;

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
  final List<MedicalReportEntity> _reports;
  @override
  @JsonKey()
  List<MedicalReportEntity> get reports {
    if (_reports is EqualUnmodifiableListView) return _reports;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reports);
  }

  /// Create a copy of VisitEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VisitEntityCopyWith<_VisitEntity> get copyWith =>
      __$VisitEntityCopyWithImpl<_VisitEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VisitEntity &&
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

  @override
  int get hashCode => Object.hash(runtimeType, id, date, assessment, diagnosis,
      prescription, notes, const DeepCollectionEquality().hash(_reports));

  @override
  String toString() {
    return 'VisitEntity(id: $id, date: $date, assessment: $assessment, diagnosis: $diagnosis, prescription: $prescription, notes: $notes, reports: $reports)';
  }
}

/// @nodoc
abstract mixin class _$VisitEntityCopyWith<$Res>
    implements $VisitEntityCopyWith<$Res> {
  factory _$VisitEntityCopyWith(
          _VisitEntity value, $Res Function(_VisitEntity) _then) =
      __$VisitEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime date,
      String assessment,
      String diagnosis,
      String prescription,
      String? notes,
      List<MedicalReportEntity> reports});
}

/// @nodoc
class __$VisitEntityCopyWithImpl<$Res> implements _$VisitEntityCopyWith<$Res> {
  __$VisitEntityCopyWithImpl(this._self, this._then);

  final _VisitEntity _self;
  final $Res Function(_VisitEntity) _then;

  /// Create a copy of VisitEntity
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
    return _then(_VisitEntity(
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
              as List<MedicalReportEntity>,
    ));
  }
}

/// @nodoc
mixin _$MedicalReportEntity {
  String get id;
  String get name;
  String get fileUrl;
  DateTime get date;
  String get type;

  /// Create a copy of MedicalReportEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedicalReportEntityCopyWith<MedicalReportEntity> get copyWith =>
      _$MedicalReportEntityCopyWithImpl<MedicalReportEntity>(
          this as MedicalReportEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedicalReportEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, fileUrl, date, type);

  @override
  String toString() {
    return 'MedicalReportEntity(id: $id, name: $name, fileUrl: $fileUrl, date: $date, type: $type)';
  }
}

/// @nodoc
abstract mixin class $MedicalReportEntityCopyWith<$Res> {
  factory $MedicalReportEntityCopyWith(
          MedicalReportEntity value, $Res Function(MedicalReportEntity) _then) =
      _$MedicalReportEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id, String name, String fileUrl, DateTime date, String type});
}

/// @nodoc
class _$MedicalReportEntityCopyWithImpl<$Res>
    implements $MedicalReportEntityCopyWith<$Res> {
  _$MedicalReportEntityCopyWithImpl(this._self, this._then);

  final MedicalReportEntity _self;
  final $Res Function(MedicalReportEntity) _then;

  /// Create a copy of MedicalReportEntity
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

/// Adds pattern-matching-related methods to [MedicalReportEntity].
extension MedicalReportEntityPatterns on MedicalReportEntity {
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
    TResult Function(_MedicalReportEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MedicalReportEntity() when $default != null:
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
    TResult Function(_MedicalReportEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicalReportEntity():
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
    TResult? Function(_MedicalReportEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicalReportEntity() when $default != null:
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
      case _MedicalReportEntity() when $default != null:
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
      case _MedicalReportEntity():
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
      case _MedicalReportEntity() when $default != null:
        return $default(
            _that.id, _that.name, _that.fileUrl, _that.date, _that.type);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MedicalReportEntity implements MedicalReportEntity {
  const _MedicalReportEntity(
      {required this.id,
      required this.name,
      required this.fileUrl,
      required this.date,
      required this.type});

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

  /// Create a copy of MedicalReportEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MedicalReportEntityCopyWith<_MedicalReportEntity> get copyWith =>
      __$MedicalReportEntityCopyWithImpl<_MedicalReportEntity>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MedicalReportEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, fileUrl, date, type);

  @override
  String toString() {
    return 'MedicalReportEntity(id: $id, name: $name, fileUrl: $fileUrl, date: $date, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$MedicalReportEntityCopyWith<$Res>
    implements $MedicalReportEntityCopyWith<$Res> {
  factory _$MedicalReportEntityCopyWith(_MedicalReportEntity value,
          $Res Function(_MedicalReportEntity) _then) =
      __$MedicalReportEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id, String name, String fileUrl, DateTime date, String type});
}

/// @nodoc
class __$MedicalReportEntityCopyWithImpl<$Res>
    implements _$MedicalReportEntityCopyWith<$Res> {
  __$MedicalReportEntityCopyWithImpl(this._self, this._then);

  final _MedicalReportEntity _self;
  final $Res Function(_MedicalReportEntity) _then;

  /// Create a copy of MedicalReportEntity
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
    return _then(_MedicalReportEntity(
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
