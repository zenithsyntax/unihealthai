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
  String get doctorId; // 🧍 Personal / Demographics
  String get firstName;
  String get lastName;
  String get gender;
  DateTime get dateOfBirth;
  String get nationality;
  String get maritalStatus;
  String get occupation; // 📞 Contact / Emergency
  String get contactNumber;
  String get emergencyContactName;
  String get emergencyContactPhone;
  String get emergencyContactRelationship; // 🏥 Medical History
  String get bloodType;
  bool get hasHeartCondition;
  bool get hasDiabetes;
  bool get hasAsthma;
  bool get hasHighBloodPressure;
  bool get hasSurgicalHistory;
  String? get surgeryDetails;
  String? get familyMedicalHistory; // 💊 Medications & Allergies
  bool get isTakingMedication;
  String? get currentMedications;
  String? get drugAllergyDetails;
  String? get foodAllergyDetails; // 🧠 Mental & Lifestyle
  String? get mentalHealthNotes;
  String get smokingStatus;
  String get alcoholConsumption;
  String get physicalActivityLevel;
  int? get sleepHoursPerNight; // 📏 Body Metrics / Vitals
  double get height; // in cm
  double get weight; // in kg
  double? get bmi;
  int? get restingHeartRate;
  String? get bloodPressure; // 📄 Administrative / Consent
  String? get insuranceProvider;
  String? get insurancePolicyNumber;
  bool get consentToTreatment;
  DateTime? get consentDate;
  String? get notes; // 🗂 Files / Metadata
  String? get profilePhotoUrl;
  List<String> get additionalDocuments;
  DateTime get createdAt;
  DateTime get updatedAt; // Visits
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
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            (identical(other.maritalStatus, maritalStatus) ||
                other.maritalStatus == maritalStatus) &&
            (identical(other.occupation, occupation) ||
                other.occupation == occupation) &&
            (identical(other.contactNumber, contactNumber) ||
                other.contactNumber == contactNumber) &&
            (identical(other.emergencyContactName, emergencyContactName) ||
                other.emergencyContactName == emergencyContactName) &&
            (identical(other.emergencyContactPhone, emergencyContactPhone) ||
                other.emergencyContactPhone == emergencyContactPhone) &&
            (identical(other.emergencyContactRelationship, emergencyContactRelationship) ||
                other.emergencyContactRelationship ==
                    emergencyContactRelationship) &&
            (identical(other.bloodType, bloodType) ||
                other.bloodType == bloodType) &&
            (identical(other.hasHeartCondition, hasHeartCondition) ||
                other.hasHeartCondition == hasHeartCondition) &&
            (identical(other.hasDiabetes, hasDiabetes) ||
                other.hasDiabetes == hasDiabetes) &&
            (identical(other.hasAsthma, hasAsthma) ||
                other.hasAsthma == hasAsthma) &&
            (identical(other.hasHighBloodPressure, hasHighBloodPressure) ||
                other.hasHighBloodPressure == hasHighBloodPressure) &&
            (identical(other.hasSurgicalHistory, hasSurgicalHistory) ||
                other.hasSurgicalHistory == hasSurgicalHistory) &&
            (identical(other.surgeryDetails, surgeryDetails) ||
                other.surgeryDetails == surgeryDetails) &&
            (identical(other.familyMedicalHistory, familyMedicalHistory) ||
                other.familyMedicalHistory == familyMedicalHistory) &&
            (identical(other.isTakingMedication, isTakingMedication) ||
                other.isTakingMedication == isTakingMedication) &&
            (identical(other.currentMedications, currentMedications) ||
                other.currentMedications == currentMedications) &&
            (identical(other.drugAllergyDetails, drugAllergyDetails) ||
                other.drugAllergyDetails == drugAllergyDetails) &&
            (identical(other.foodAllergyDetails, foodAllergyDetails) ||
                other.foodAllergyDetails == foodAllergyDetails) &&
            (identical(other.mentalHealthNotes, mentalHealthNotes) ||
                other.mentalHealthNotes == mentalHealthNotes) &&
            (identical(other.smokingStatus, smokingStatus) ||
                other.smokingStatus == smokingStatus) &&
            (identical(other.alcoholConsumption, alcoholConsumption) ||
                other.alcoholConsumption == alcoholConsumption) &&
            (identical(other.physicalActivityLevel, physicalActivityLevel) ||
                other.physicalActivityLevel == physicalActivityLevel) &&
            (identical(other.sleepHoursPerNight, sleepHoursPerNight) ||
                other.sleepHoursPerNight == sleepHoursPerNight) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.bmi, bmi) || other.bmi == bmi) &&
            (identical(other.restingHeartRate, restingHeartRate) ||
                other.restingHeartRate == restingHeartRate) &&
            (identical(other.bloodPressure, bloodPressure) ||
                other.bloodPressure == bloodPressure) &&
            (identical(other.insuranceProvider, insuranceProvider) ||
                other.insuranceProvider == insuranceProvider) &&
            (identical(other.insurancePolicyNumber, insurancePolicyNumber) ||
                other.insurancePolicyNumber == insurancePolicyNumber) &&
            (identical(other.consentToTreatment, consentToTreatment) ||
                other.consentToTreatment == consentToTreatment) &&
            (identical(other.consentDate, consentDate) ||
                other.consentDate == consentDate) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.profilePhotoUrl, profilePhotoUrl) ||
                other.profilePhotoUrl == profilePhotoUrl) &&
            const DeepCollectionEquality().equals(other.additionalDocuments, additionalDocuments) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other.visits, visits));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        doctorId,
        firstName,
        lastName,
        gender,
        dateOfBirth,
        nationality,
        maritalStatus,
        occupation,
        contactNumber,
        emergencyContactName,
        emergencyContactPhone,
        emergencyContactRelationship,
        bloodType,
        hasHeartCondition,
        hasDiabetes,
        hasAsthma,
        hasHighBloodPressure,
        hasSurgicalHistory,
        surgeryDetails,
        familyMedicalHistory,
        isTakingMedication,
        currentMedications,
        drugAllergyDetails,
        foodAllergyDetails,
        mentalHealthNotes,
        smokingStatus,
        alcoholConsumption,
        physicalActivityLevel,
        sleepHoursPerNight,
        height,
        weight,
        bmi,
        restingHeartRate,
        bloodPressure,
        insuranceProvider,
        insurancePolicyNumber,
        consentToTreatment,
        consentDate,
        notes,
        profilePhotoUrl,
        const DeepCollectionEquality().hash(additionalDocuments),
        createdAt,
        updatedAt,
        const DeepCollectionEquality().hash(visits)
      ]);

  @override
  String toString() {
    return 'PatientEntity(id: $id, doctorId: $doctorId, firstName: $firstName, lastName: $lastName, gender: $gender, dateOfBirth: $dateOfBirth, nationality: $nationality, maritalStatus: $maritalStatus, occupation: $occupation, contactNumber: $contactNumber, emergencyContactName: $emergencyContactName, emergencyContactPhone: $emergencyContactPhone, emergencyContactRelationship: $emergencyContactRelationship, bloodType: $bloodType, hasHeartCondition: $hasHeartCondition, hasDiabetes: $hasDiabetes, hasAsthma: $hasAsthma, hasHighBloodPressure: $hasHighBloodPressure, hasSurgicalHistory: $hasSurgicalHistory, surgeryDetails: $surgeryDetails, familyMedicalHistory: $familyMedicalHistory, isTakingMedication: $isTakingMedication, currentMedications: $currentMedications, drugAllergyDetails: $drugAllergyDetails, foodAllergyDetails: $foodAllergyDetails, mentalHealthNotes: $mentalHealthNotes, smokingStatus: $smokingStatus, alcoholConsumption: $alcoholConsumption, physicalActivityLevel: $physicalActivityLevel, sleepHoursPerNight: $sleepHoursPerNight, height: $height, weight: $weight, bmi: $bmi, restingHeartRate: $restingHeartRate, bloodPressure: $bloodPressure, insuranceProvider: $insuranceProvider, insurancePolicyNumber: $insurancePolicyNumber, consentToTreatment: $consentToTreatment, consentDate: $consentDate, notes: $notes, profilePhotoUrl: $profilePhotoUrl, additionalDocuments: $additionalDocuments, createdAt: $createdAt, updatedAt: $updatedAt, visits: $visits)';
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
      String firstName,
      String lastName,
      String gender,
      DateTime dateOfBirth,
      String nationality,
      String maritalStatus,
      String occupation,
      String contactNumber,
      String emergencyContactName,
      String emergencyContactPhone,
      String emergencyContactRelationship,
      String bloodType,
      bool hasHeartCondition,
      bool hasDiabetes,
      bool hasAsthma,
      bool hasHighBloodPressure,
      bool hasSurgicalHistory,
      String? surgeryDetails,
      String? familyMedicalHistory,
      bool isTakingMedication,
      String? currentMedications,
      String? drugAllergyDetails,
      String? foodAllergyDetails,
      String? mentalHealthNotes,
      String smokingStatus,
      String alcoholConsumption,
      String physicalActivityLevel,
      int? sleepHoursPerNight,
      double height,
      double weight,
      double? bmi,
      int? restingHeartRate,
      String? bloodPressure,
      String? insuranceProvider,
      String? insurancePolicyNumber,
      bool consentToTreatment,
      DateTime? consentDate,
      String? notes,
      String? profilePhotoUrl,
      List<String> additionalDocuments,
      DateTime createdAt,
      DateTime updatedAt,
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
    Object? firstName = null,
    Object? lastName = null,
    Object? gender = null,
    Object? dateOfBirth = null,
    Object? nationality = null,
    Object? maritalStatus = null,
    Object? occupation = null,
    Object? contactNumber = null,
    Object? emergencyContactName = null,
    Object? emergencyContactPhone = null,
    Object? emergencyContactRelationship = null,
    Object? bloodType = null,
    Object? hasHeartCondition = null,
    Object? hasDiabetes = null,
    Object? hasAsthma = null,
    Object? hasHighBloodPressure = null,
    Object? hasSurgicalHistory = null,
    Object? surgeryDetails = freezed,
    Object? familyMedicalHistory = freezed,
    Object? isTakingMedication = null,
    Object? currentMedications = freezed,
    Object? drugAllergyDetails = freezed,
    Object? foodAllergyDetails = freezed,
    Object? mentalHealthNotes = freezed,
    Object? smokingStatus = null,
    Object? alcoholConsumption = null,
    Object? physicalActivityLevel = null,
    Object? sleepHoursPerNight = freezed,
    Object? height = null,
    Object? weight = null,
    Object? bmi = freezed,
    Object? restingHeartRate = freezed,
    Object? bloodPressure = freezed,
    Object? insuranceProvider = freezed,
    Object? insurancePolicyNumber = freezed,
    Object? consentToTreatment = null,
    Object? consentDate = freezed,
    Object? notes = freezed,
    Object? profilePhotoUrl = freezed,
    Object? additionalDocuments = null,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      firstName: null == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: null == dateOfBirth
          ? _self.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      nationality: null == nationality
          ? _self.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String,
      maritalStatus: null == maritalStatus
          ? _self.maritalStatus
          : maritalStatus // ignore: cast_nullable_to_non_nullable
              as String,
      occupation: null == occupation
          ? _self.occupation
          : occupation // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: null == contactNumber
          ? _self.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyContactName: null == emergencyContactName
          ? _self.emergencyContactName
          : emergencyContactName // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyContactPhone: null == emergencyContactPhone
          ? _self.emergencyContactPhone
          : emergencyContactPhone // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyContactRelationship: null == emergencyContactRelationship
          ? _self.emergencyContactRelationship
          : emergencyContactRelationship // ignore: cast_nullable_to_non_nullable
              as String,
      bloodType: null == bloodType
          ? _self.bloodType
          : bloodType // ignore: cast_nullable_to_non_nullable
              as String,
      hasHeartCondition: null == hasHeartCondition
          ? _self.hasHeartCondition
          : hasHeartCondition // ignore: cast_nullable_to_non_nullable
              as bool,
      hasDiabetes: null == hasDiabetes
          ? _self.hasDiabetes
          : hasDiabetes // ignore: cast_nullable_to_non_nullable
              as bool,
      hasAsthma: null == hasAsthma
          ? _self.hasAsthma
          : hasAsthma // ignore: cast_nullable_to_non_nullable
              as bool,
      hasHighBloodPressure: null == hasHighBloodPressure
          ? _self.hasHighBloodPressure
          : hasHighBloodPressure // ignore: cast_nullable_to_non_nullable
              as bool,
      hasSurgicalHistory: null == hasSurgicalHistory
          ? _self.hasSurgicalHistory
          : hasSurgicalHistory // ignore: cast_nullable_to_non_nullable
              as bool,
      surgeryDetails: freezed == surgeryDetails
          ? _self.surgeryDetails
          : surgeryDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      familyMedicalHistory: freezed == familyMedicalHistory
          ? _self.familyMedicalHistory
          : familyMedicalHistory // ignore: cast_nullable_to_non_nullable
              as String?,
      isTakingMedication: null == isTakingMedication
          ? _self.isTakingMedication
          : isTakingMedication // ignore: cast_nullable_to_non_nullable
              as bool,
      currentMedications: freezed == currentMedications
          ? _self.currentMedications
          : currentMedications // ignore: cast_nullable_to_non_nullable
              as String?,
      drugAllergyDetails: freezed == drugAllergyDetails
          ? _self.drugAllergyDetails
          : drugAllergyDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      foodAllergyDetails: freezed == foodAllergyDetails
          ? _self.foodAllergyDetails
          : foodAllergyDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      mentalHealthNotes: freezed == mentalHealthNotes
          ? _self.mentalHealthNotes
          : mentalHealthNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      smokingStatus: null == smokingStatus
          ? _self.smokingStatus
          : smokingStatus // ignore: cast_nullable_to_non_nullable
              as String,
      alcoholConsumption: null == alcoholConsumption
          ? _self.alcoholConsumption
          : alcoholConsumption // ignore: cast_nullable_to_non_nullable
              as String,
      physicalActivityLevel: null == physicalActivityLevel
          ? _self.physicalActivityLevel
          : physicalActivityLevel // ignore: cast_nullable_to_non_nullable
              as String,
      sleepHoursPerNight: freezed == sleepHoursPerNight
          ? _self.sleepHoursPerNight
          : sleepHoursPerNight // ignore: cast_nullable_to_non_nullable
              as int?,
      height: null == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      bmi: freezed == bmi
          ? _self.bmi
          : bmi // ignore: cast_nullable_to_non_nullable
              as double?,
      restingHeartRate: freezed == restingHeartRate
          ? _self.restingHeartRate
          : restingHeartRate // ignore: cast_nullable_to_non_nullable
              as int?,
      bloodPressure: freezed == bloodPressure
          ? _self.bloodPressure
          : bloodPressure // ignore: cast_nullable_to_non_nullable
              as String?,
      insuranceProvider: freezed == insuranceProvider
          ? _self.insuranceProvider
          : insuranceProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      insurancePolicyNumber: freezed == insurancePolicyNumber
          ? _self.insurancePolicyNumber
          : insurancePolicyNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      consentToTreatment: null == consentToTreatment
          ? _self.consentToTreatment
          : consentToTreatment // ignore: cast_nullable_to_non_nullable
              as bool,
      consentDate: freezed == consentDate
          ? _self.consentDate
          : consentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePhotoUrl: freezed == profilePhotoUrl
          ? _self.profilePhotoUrl
          : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalDocuments: null == additionalDocuments
          ? _self.additionalDocuments
          : additionalDocuments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
    TResult Function(
            String id,
            String doctorId,
            String firstName,
            String lastName,
            String gender,
            DateTime dateOfBirth,
            String nationality,
            String maritalStatus,
            String occupation,
            String contactNumber,
            String emergencyContactName,
            String emergencyContactPhone,
            String emergencyContactRelationship,
            String bloodType,
            bool hasHeartCondition,
            bool hasDiabetes,
            bool hasAsthma,
            bool hasHighBloodPressure,
            bool hasSurgicalHistory,
            String? surgeryDetails,
            String? familyMedicalHistory,
            bool isTakingMedication,
            String? currentMedications,
            String? drugAllergyDetails,
            String? foodAllergyDetails,
            String? mentalHealthNotes,
            String smokingStatus,
            String alcoholConsumption,
            String physicalActivityLevel,
            int? sleepHoursPerNight,
            double height,
            double weight,
            double? bmi,
            int? restingHeartRate,
            String? bloodPressure,
            String? insuranceProvider,
            String? insurancePolicyNumber,
            bool consentToTreatment,
            DateTime? consentDate,
            String? notes,
            String? profilePhotoUrl,
            List<String> additionalDocuments,
            DateTime createdAt,
            DateTime updatedAt,
            List<VisitEntity> visits)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PatientEntity() when $default != null:
        return $default(
            _that.id,
            _that.doctorId,
            _that.firstName,
            _that.lastName,
            _that.gender,
            _that.dateOfBirth,
            _that.nationality,
            _that.maritalStatus,
            _that.occupation,
            _that.contactNumber,
            _that.emergencyContactName,
            _that.emergencyContactPhone,
            _that.emergencyContactRelationship,
            _that.bloodType,
            _that.hasHeartCondition,
            _that.hasDiabetes,
            _that.hasAsthma,
            _that.hasHighBloodPressure,
            _that.hasSurgicalHistory,
            _that.surgeryDetails,
            _that.familyMedicalHistory,
            _that.isTakingMedication,
            _that.currentMedications,
            _that.drugAllergyDetails,
            _that.foodAllergyDetails,
            _that.mentalHealthNotes,
            _that.smokingStatus,
            _that.alcoholConsumption,
            _that.physicalActivityLevel,
            _that.sleepHoursPerNight,
            _that.height,
            _that.weight,
            _that.bmi,
            _that.restingHeartRate,
            _that.bloodPressure,
            _that.insuranceProvider,
            _that.insurancePolicyNumber,
            _that.consentToTreatment,
            _that.consentDate,
            _that.notes,
            _that.profilePhotoUrl,
            _that.additionalDocuments,
            _that.createdAt,
            _that.updatedAt,
            _that.visits);
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
            String doctorId,
            String firstName,
            String lastName,
            String gender,
            DateTime dateOfBirth,
            String nationality,
            String maritalStatus,
            String occupation,
            String contactNumber,
            String emergencyContactName,
            String emergencyContactPhone,
            String emergencyContactRelationship,
            String bloodType,
            bool hasHeartCondition,
            bool hasDiabetes,
            bool hasAsthma,
            bool hasHighBloodPressure,
            bool hasSurgicalHistory,
            String? surgeryDetails,
            String? familyMedicalHistory,
            bool isTakingMedication,
            String? currentMedications,
            String? drugAllergyDetails,
            String? foodAllergyDetails,
            String? mentalHealthNotes,
            String smokingStatus,
            String alcoholConsumption,
            String physicalActivityLevel,
            int? sleepHoursPerNight,
            double height,
            double weight,
            double? bmi,
            int? restingHeartRate,
            String? bloodPressure,
            String? insuranceProvider,
            String? insurancePolicyNumber,
            bool consentToTreatment,
            DateTime? consentDate,
            String? notes,
            String? profilePhotoUrl,
            List<String> additionalDocuments,
            DateTime createdAt,
            DateTime updatedAt,
            List<VisitEntity> visits)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatientEntity():
        return $default(
            _that.id,
            _that.doctorId,
            _that.firstName,
            _that.lastName,
            _that.gender,
            _that.dateOfBirth,
            _that.nationality,
            _that.maritalStatus,
            _that.occupation,
            _that.contactNumber,
            _that.emergencyContactName,
            _that.emergencyContactPhone,
            _that.emergencyContactRelationship,
            _that.bloodType,
            _that.hasHeartCondition,
            _that.hasDiabetes,
            _that.hasAsthma,
            _that.hasHighBloodPressure,
            _that.hasSurgicalHistory,
            _that.surgeryDetails,
            _that.familyMedicalHistory,
            _that.isTakingMedication,
            _that.currentMedications,
            _that.drugAllergyDetails,
            _that.foodAllergyDetails,
            _that.mentalHealthNotes,
            _that.smokingStatus,
            _that.alcoholConsumption,
            _that.physicalActivityLevel,
            _that.sleepHoursPerNight,
            _that.height,
            _that.weight,
            _that.bmi,
            _that.restingHeartRate,
            _that.bloodPressure,
            _that.insuranceProvider,
            _that.insurancePolicyNumber,
            _that.consentToTreatment,
            _that.consentDate,
            _that.notes,
            _that.profilePhotoUrl,
            _that.additionalDocuments,
            _that.createdAt,
            _that.updatedAt,
            _that.visits);
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
            String doctorId,
            String firstName,
            String lastName,
            String gender,
            DateTime dateOfBirth,
            String nationality,
            String maritalStatus,
            String occupation,
            String contactNumber,
            String emergencyContactName,
            String emergencyContactPhone,
            String emergencyContactRelationship,
            String bloodType,
            bool hasHeartCondition,
            bool hasDiabetes,
            bool hasAsthma,
            bool hasHighBloodPressure,
            bool hasSurgicalHistory,
            String? surgeryDetails,
            String? familyMedicalHistory,
            bool isTakingMedication,
            String? currentMedications,
            String? drugAllergyDetails,
            String? foodAllergyDetails,
            String? mentalHealthNotes,
            String smokingStatus,
            String alcoholConsumption,
            String physicalActivityLevel,
            int? sleepHoursPerNight,
            double height,
            double weight,
            double? bmi,
            int? restingHeartRate,
            String? bloodPressure,
            String? insuranceProvider,
            String? insurancePolicyNumber,
            bool consentToTreatment,
            DateTime? consentDate,
            String? notes,
            String? profilePhotoUrl,
            List<String> additionalDocuments,
            DateTime createdAt,
            DateTime updatedAt,
            List<VisitEntity> visits)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PatientEntity() when $default != null:
        return $default(
            _that.id,
            _that.doctorId,
            _that.firstName,
            _that.lastName,
            _that.gender,
            _that.dateOfBirth,
            _that.nationality,
            _that.maritalStatus,
            _that.occupation,
            _that.contactNumber,
            _that.emergencyContactName,
            _that.emergencyContactPhone,
            _that.emergencyContactRelationship,
            _that.bloodType,
            _that.hasHeartCondition,
            _that.hasDiabetes,
            _that.hasAsthma,
            _that.hasHighBloodPressure,
            _that.hasSurgicalHistory,
            _that.surgeryDetails,
            _that.familyMedicalHistory,
            _that.isTakingMedication,
            _that.currentMedications,
            _that.drugAllergyDetails,
            _that.foodAllergyDetails,
            _that.mentalHealthNotes,
            _that.smokingStatus,
            _that.alcoholConsumption,
            _that.physicalActivityLevel,
            _that.sleepHoursPerNight,
            _that.height,
            _that.weight,
            _that.bmi,
            _that.restingHeartRate,
            _that.bloodPressure,
            _that.insuranceProvider,
            _that.insurancePolicyNumber,
            _that.consentToTreatment,
            _that.consentDate,
            _that.notes,
            _that.profilePhotoUrl,
            _that.additionalDocuments,
            _that.createdAt,
            _that.updatedAt,
            _that.visits);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PatientEntity extends PatientEntity {
  const _PatientEntity(
      {required this.id,
      required this.doctorId,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.dateOfBirth,
      required this.nationality,
      required this.maritalStatus,
      required this.occupation,
      required this.contactNumber,
      required this.emergencyContactName,
      required this.emergencyContactPhone,
      required this.emergencyContactRelationship,
      required this.bloodType,
      required this.hasHeartCondition,
      required this.hasDiabetes,
      required this.hasAsthma,
      required this.hasHighBloodPressure,
      required this.hasSurgicalHistory,
      this.surgeryDetails,
      this.familyMedicalHistory,
      required this.isTakingMedication,
      this.currentMedications,
      this.drugAllergyDetails,
      this.foodAllergyDetails,
      this.mentalHealthNotes,
      required this.smokingStatus,
      required this.alcoholConsumption,
      required this.physicalActivityLevel,
      this.sleepHoursPerNight,
      required this.height,
      required this.weight,
      this.bmi,
      this.restingHeartRate,
      this.bloodPressure,
      this.insuranceProvider,
      this.insurancePolicyNumber,
      required this.consentToTreatment,
      this.consentDate,
      this.notes,
      this.profilePhotoUrl,
      final List<String> additionalDocuments = const [],
      required this.createdAt,
      required this.updatedAt,
      final List<VisitEntity> visits = const []})
      : _additionalDocuments = additionalDocuments,
        _visits = visits,
        super._();

  @override
  final String id;
  @override
  final String doctorId;
// 🧍 Personal / Demographics
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String gender;
  @override
  final DateTime dateOfBirth;
  @override
  final String nationality;
  @override
  final String maritalStatus;
  @override
  final String occupation;
// 📞 Contact / Emergency
  @override
  final String contactNumber;
  @override
  final String emergencyContactName;
  @override
  final String emergencyContactPhone;
  @override
  final String emergencyContactRelationship;
// 🏥 Medical History
  @override
  final String bloodType;
  @override
  final bool hasHeartCondition;
  @override
  final bool hasDiabetes;
  @override
  final bool hasAsthma;
  @override
  final bool hasHighBloodPressure;
  @override
  final bool hasSurgicalHistory;
  @override
  final String? surgeryDetails;
  @override
  final String? familyMedicalHistory;
// 💊 Medications & Allergies
  @override
  final bool isTakingMedication;
  @override
  final String? currentMedications;
  @override
  final String? drugAllergyDetails;
  @override
  final String? foodAllergyDetails;
// 🧠 Mental & Lifestyle
  @override
  final String? mentalHealthNotes;
  @override
  final String smokingStatus;
  @override
  final String alcoholConsumption;
  @override
  final String physicalActivityLevel;
  @override
  final int? sleepHoursPerNight;
// 📏 Body Metrics / Vitals
  @override
  final double height;
// in cm
  @override
  final double weight;
// in kg
  @override
  final double? bmi;
  @override
  final int? restingHeartRate;
  @override
  final String? bloodPressure;
// 📄 Administrative / Consent
  @override
  final String? insuranceProvider;
  @override
  final String? insurancePolicyNumber;
  @override
  final bool consentToTreatment;
  @override
  final DateTime? consentDate;
  @override
  final String? notes;
// 🗂 Files / Metadata
  @override
  final String? profilePhotoUrl;
  final List<String> _additionalDocuments;
  @override
  @JsonKey()
  List<String> get additionalDocuments {
    if (_additionalDocuments is EqualUnmodifiableListView)
      return _additionalDocuments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_additionalDocuments);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
// Visits
  final List<VisitEntity> _visits;
// Visits
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
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            (identical(other.maritalStatus, maritalStatus) ||
                other.maritalStatus == maritalStatus) &&
            (identical(other.occupation, occupation) ||
                other.occupation == occupation) &&
            (identical(other.contactNumber, contactNumber) ||
                other.contactNumber == contactNumber) &&
            (identical(other.emergencyContactName, emergencyContactName) ||
                other.emergencyContactName == emergencyContactName) &&
            (identical(other.emergencyContactPhone, emergencyContactPhone) ||
                other.emergencyContactPhone == emergencyContactPhone) &&
            (identical(other.emergencyContactRelationship, emergencyContactRelationship) ||
                other.emergencyContactRelationship ==
                    emergencyContactRelationship) &&
            (identical(other.bloodType, bloodType) ||
                other.bloodType == bloodType) &&
            (identical(other.hasHeartCondition, hasHeartCondition) ||
                other.hasHeartCondition == hasHeartCondition) &&
            (identical(other.hasDiabetes, hasDiabetes) ||
                other.hasDiabetes == hasDiabetes) &&
            (identical(other.hasAsthma, hasAsthma) ||
                other.hasAsthma == hasAsthma) &&
            (identical(other.hasHighBloodPressure, hasHighBloodPressure) ||
                other.hasHighBloodPressure == hasHighBloodPressure) &&
            (identical(other.hasSurgicalHistory, hasSurgicalHistory) ||
                other.hasSurgicalHistory == hasSurgicalHistory) &&
            (identical(other.surgeryDetails, surgeryDetails) ||
                other.surgeryDetails == surgeryDetails) &&
            (identical(other.familyMedicalHistory, familyMedicalHistory) ||
                other.familyMedicalHistory == familyMedicalHistory) &&
            (identical(other.isTakingMedication, isTakingMedication) ||
                other.isTakingMedication == isTakingMedication) &&
            (identical(other.currentMedications, currentMedications) ||
                other.currentMedications == currentMedications) &&
            (identical(other.drugAllergyDetails, drugAllergyDetails) ||
                other.drugAllergyDetails == drugAllergyDetails) &&
            (identical(other.foodAllergyDetails, foodAllergyDetails) ||
                other.foodAllergyDetails == foodAllergyDetails) &&
            (identical(other.mentalHealthNotes, mentalHealthNotes) ||
                other.mentalHealthNotes == mentalHealthNotes) &&
            (identical(other.smokingStatus, smokingStatus) ||
                other.smokingStatus == smokingStatus) &&
            (identical(other.alcoholConsumption, alcoholConsumption) ||
                other.alcoholConsumption == alcoholConsumption) &&
            (identical(other.physicalActivityLevel, physicalActivityLevel) ||
                other.physicalActivityLevel == physicalActivityLevel) &&
            (identical(other.sleepHoursPerNight, sleepHoursPerNight) ||
                other.sleepHoursPerNight == sleepHoursPerNight) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.bmi, bmi) || other.bmi == bmi) &&
            (identical(other.restingHeartRate, restingHeartRate) ||
                other.restingHeartRate == restingHeartRate) &&
            (identical(other.bloodPressure, bloodPressure) ||
                other.bloodPressure == bloodPressure) &&
            (identical(other.insuranceProvider, insuranceProvider) ||
                other.insuranceProvider == insuranceProvider) &&
            (identical(other.insurancePolicyNumber, insurancePolicyNumber) ||
                other.insurancePolicyNumber == insurancePolicyNumber) &&
            (identical(other.consentToTreatment, consentToTreatment) ||
                other.consentToTreatment == consentToTreatment) &&
            (identical(other.consentDate, consentDate) ||
                other.consentDate == consentDate) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.profilePhotoUrl, profilePhotoUrl) ||
                other.profilePhotoUrl == profilePhotoUrl) &&
            const DeepCollectionEquality().equals(other._additionalDocuments, _additionalDocuments) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._visits, _visits));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        doctorId,
        firstName,
        lastName,
        gender,
        dateOfBirth,
        nationality,
        maritalStatus,
        occupation,
        contactNumber,
        emergencyContactName,
        emergencyContactPhone,
        emergencyContactRelationship,
        bloodType,
        hasHeartCondition,
        hasDiabetes,
        hasAsthma,
        hasHighBloodPressure,
        hasSurgicalHistory,
        surgeryDetails,
        familyMedicalHistory,
        isTakingMedication,
        currentMedications,
        drugAllergyDetails,
        foodAllergyDetails,
        mentalHealthNotes,
        smokingStatus,
        alcoholConsumption,
        physicalActivityLevel,
        sleepHoursPerNight,
        height,
        weight,
        bmi,
        restingHeartRate,
        bloodPressure,
        insuranceProvider,
        insurancePolicyNumber,
        consentToTreatment,
        consentDate,
        notes,
        profilePhotoUrl,
        const DeepCollectionEquality().hash(_additionalDocuments),
        createdAt,
        updatedAt,
        const DeepCollectionEquality().hash(_visits)
      ]);

  @override
  String toString() {
    return 'PatientEntity(id: $id, doctorId: $doctorId, firstName: $firstName, lastName: $lastName, gender: $gender, dateOfBirth: $dateOfBirth, nationality: $nationality, maritalStatus: $maritalStatus, occupation: $occupation, contactNumber: $contactNumber, emergencyContactName: $emergencyContactName, emergencyContactPhone: $emergencyContactPhone, emergencyContactRelationship: $emergencyContactRelationship, bloodType: $bloodType, hasHeartCondition: $hasHeartCondition, hasDiabetes: $hasDiabetes, hasAsthma: $hasAsthma, hasHighBloodPressure: $hasHighBloodPressure, hasSurgicalHistory: $hasSurgicalHistory, surgeryDetails: $surgeryDetails, familyMedicalHistory: $familyMedicalHistory, isTakingMedication: $isTakingMedication, currentMedications: $currentMedications, drugAllergyDetails: $drugAllergyDetails, foodAllergyDetails: $foodAllergyDetails, mentalHealthNotes: $mentalHealthNotes, smokingStatus: $smokingStatus, alcoholConsumption: $alcoholConsumption, physicalActivityLevel: $physicalActivityLevel, sleepHoursPerNight: $sleepHoursPerNight, height: $height, weight: $weight, bmi: $bmi, restingHeartRate: $restingHeartRate, bloodPressure: $bloodPressure, insuranceProvider: $insuranceProvider, insurancePolicyNumber: $insurancePolicyNumber, consentToTreatment: $consentToTreatment, consentDate: $consentDate, notes: $notes, profilePhotoUrl: $profilePhotoUrl, additionalDocuments: $additionalDocuments, createdAt: $createdAt, updatedAt: $updatedAt, visits: $visits)';
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
      String firstName,
      String lastName,
      String gender,
      DateTime dateOfBirth,
      String nationality,
      String maritalStatus,
      String occupation,
      String contactNumber,
      String emergencyContactName,
      String emergencyContactPhone,
      String emergencyContactRelationship,
      String bloodType,
      bool hasHeartCondition,
      bool hasDiabetes,
      bool hasAsthma,
      bool hasHighBloodPressure,
      bool hasSurgicalHistory,
      String? surgeryDetails,
      String? familyMedicalHistory,
      bool isTakingMedication,
      String? currentMedications,
      String? drugAllergyDetails,
      String? foodAllergyDetails,
      String? mentalHealthNotes,
      String smokingStatus,
      String alcoholConsumption,
      String physicalActivityLevel,
      int? sleepHoursPerNight,
      double height,
      double weight,
      double? bmi,
      int? restingHeartRate,
      String? bloodPressure,
      String? insuranceProvider,
      String? insurancePolicyNumber,
      bool consentToTreatment,
      DateTime? consentDate,
      String? notes,
      String? profilePhotoUrl,
      List<String> additionalDocuments,
      DateTime createdAt,
      DateTime updatedAt,
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
    Object? firstName = null,
    Object? lastName = null,
    Object? gender = null,
    Object? dateOfBirth = null,
    Object? nationality = null,
    Object? maritalStatus = null,
    Object? occupation = null,
    Object? contactNumber = null,
    Object? emergencyContactName = null,
    Object? emergencyContactPhone = null,
    Object? emergencyContactRelationship = null,
    Object? bloodType = null,
    Object? hasHeartCondition = null,
    Object? hasDiabetes = null,
    Object? hasAsthma = null,
    Object? hasHighBloodPressure = null,
    Object? hasSurgicalHistory = null,
    Object? surgeryDetails = freezed,
    Object? familyMedicalHistory = freezed,
    Object? isTakingMedication = null,
    Object? currentMedications = freezed,
    Object? drugAllergyDetails = freezed,
    Object? foodAllergyDetails = freezed,
    Object? mentalHealthNotes = freezed,
    Object? smokingStatus = null,
    Object? alcoholConsumption = null,
    Object? physicalActivityLevel = null,
    Object? sleepHoursPerNight = freezed,
    Object? height = null,
    Object? weight = null,
    Object? bmi = freezed,
    Object? restingHeartRate = freezed,
    Object? bloodPressure = freezed,
    Object? insuranceProvider = freezed,
    Object? insurancePolicyNumber = freezed,
    Object? consentToTreatment = null,
    Object? consentDate = freezed,
    Object? notes = freezed,
    Object? profilePhotoUrl = freezed,
    Object? additionalDocuments = null,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      firstName: null == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: null == dateOfBirth
          ? _self.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      nationality: null == nationality
          ? _self.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String,
      maritalStatus: null == maritalStatus
          ? _self.maritalStatus
          : maritalStatus // ignore: cast_nullable_to_non_nullable
              as String,
      occupation: null == occupation
          ? _self.occupation
          : occupation // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: null == contactNumber
          ? _self.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyContactName: null == emergencyContactName
          ? _self.emergencyContactName
          : emergencyContactName // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyContactPhone: null == emergencyContactPhone
          ? _self.emergencyContactPhone
          : emergencyContactPhone // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyContactRelationship: null == emergencyContactRelationship
          ? _self.emergencyContactRelationship
          : emergencyContactRelationship // ignore: cast_nullable_to_non_nullable
              as String,
      bloodType: null == bloodType
          ? _self.bloodType
          : bloodType // ignore: cast_nullable_to_non_nullable
              as String,
      hasHeartCondition: null == hasHeartCondition
          ? _self.hasHeartCondition
          : hasHeartCondition // ignore: cast_nullable_to_non_nullable
              as bool,
      hasDiabetes: null == hasDiabetes
          ? _self.hasDiabetes
          : hasDiabetes // ignore: cast_nullable_to_non_nullable
              as bool,
      hasAsthma: null == hasAsthma
          ? _self.hasAsthma
          : hasAsthma // ignore: cast_nullable_to_non_nullable
              as bool,
      hasHighBloodPressure: null == hasHighBloodPressure
          ? _self.hasHighBloodPressure
          : hasHighBloodPressure // ignore: cast_nullable_to_non_nullable
              as bool,
      hasSurgicalHistory: null == hasSurgicalHistory
          ? _self.hasSurgicalHistory
          : hasSurgicalHistory // ignore: cast_nullable_to_non_nullable
              as bool,
      surgeryDetails: freezed == surgeryDetails
          ? _self.surgeryDetails
          : surgeryDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      familyMedicalHistory: freezed == familyMedicalHistory
          ? _self.familyMedicalHistory
          : familyMedicalHistory // ignore: cast_nullable_to_non_nullable
              as String?,
      isTakingMedication: null == isTakingMedication
          ? _self.isTakingMedication
          : isTakingMedication // ignore: cast_nullable_to_non_nullable
              as bool,
      currentMedications: freezed == currentMedications
          ? _self.currentMedications
          : currentMedications // ignore: cast_nullable_to_non_nullable
              as String?,
      drugAllergyDetails: freezed == drugAllergyDetails
          ? _self.drugAllergyDetails
          : drugAllergyDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      foodAllergyDetails: freezed == foodAllergyDetails
          ? _self.foodAllergyDetails
          : foodAllergyDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      mentalHealthNotes: freezed == mentalHealthNotes
          ? _self.mentalHealthNotes
          : mentalHealthNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      smokingStatus: null == smokingStatus
          ? _self.smokingStatus
          : smokingStatus // ignore: cast_nullable_to_non_nullable
              as String,
      alcoholConsumption: null == alcoholConsumption
          ? _self.alcoholConsumption
          : alcoholConsumption // ignore: cast_nullable_to_non_nullable
              as String,
      physicalActivityLevel: null == physicalActivityLevel
          ? _self.physicalActivityLevel
          : physicalActivityLevel // ignore: cast_nullable_to_non_nullable
              as String,
      sleepHoursPerNight: freezed == sleepHoursPerNight
          ? _self.sleepHoursPerNight
          : sleepHoursPerNight // ignore: cast_nullable_to_non_nullable
              as int?,
      height: null == height
          ? _self.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      bmi: freezed == bmi
          ? _self.bmi
          : bmi // ignore: cast_nullable_to_non_nullable
              as double?,
      restingHeartRate: freezed == restingHeartRate
          ? _self.restingHeartRate
          : restingHeartRate // ignore: cast_nullable_to_non_nullable
              as int?,
      bloodPressure: freezed == bloodPressure
          ? _self.bloodPressure
          : bloodPressure // ignore: cast_nullable_to_non_nullable
              as String?,
      insuranceProvider: freezed == insuranceProvider
          ? _self.insuranceProvider
          : insuranceProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      insurancePolicyNumber: freezed == insurancePolicyNumber
          ? _self.insurancePolicyNumber
          : insurancePolicyNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      consentToTreatment: null == consentToTreatment
          ? _self.consentToTreatment
          : consentToTreatment // ignore: cast_nullable_to_non_nullable
              as bool,
      consentDate: freezed == consentDate
          ? _self.consentDate
          : consentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePhotoUrl: freezed == profilePhotoUrl
          ? _self.profilePhotoUrl
          : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalDocuments: null == additionalDocuments
          ? _self._additionalDocuments
          : additionalDocuments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
