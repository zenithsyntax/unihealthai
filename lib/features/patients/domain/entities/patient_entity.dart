import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_entity.freezed.dart';

@freezed
abstract class PatientEntity with _$PatientEntity {
  const PatientEntity._();

  const factory PatientEntity({
    required String id,
    required String doctorId,
    // 🧍 Personal / Demographics
    required String firstName,
    required String lastName,
    required String gender,
    required DateTime dateOfBirth,
    required String nationality,
    required String maritalStatus,
    required String occupation,
    // 📞 Contact / Emergency
    required String contactNumber,
    required String emergencyContactName,
    required String emergencyContactPhone,
    required String emergencyContactRelationship,
    // 🏥 Medical History
    required String bloodType,
    required bool hasHeartCondition,
    required bool hasDiabetes,
    required bool hasAsthma,
    required bool hasHighBloodPressure,
    required bool hasSurgicalHistory,
    String? surgeryDetails,
    String? familyMedicalHistory,
    // 💊 Medications & Allergies
    required bool isTakingMedication,
    String? currentMedications,
    String? drugAllergyDetails,
    String? foodAllergyDetails,
    // 🧠 Mental & Lifestyle
    String? mentalHealthNotes,
    required String smokingStatus,
    required String alcoholConsumption,
    required String physicalActivityLevel,
    int? sleepHoursPerNight,
    // 📏 Body Metrics / Vitals
    required double height, // in cm
    required double weight, // in kg
    double? bmi,
    int? restingHeartRate,
    String? bloodPressure,
    // 📄 Administrative / Consent
    String? insuranceProvider,
    String? insurancePolicyNumber,
    required bool consentToTreatment,
    DateTime? consentDate,
    String? notes,
    // 🗂 Files / Metadata
    String? profilePhotoUrl,
    @Default([]) List<String> additionalDocuments,
    required DateTime createdAt,
    required DateTime updatedAt,
    // Visits
    @Default([]) List<VisitEntity> visits,
  }) = _PatientEntity;

  // Computed age
  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  String get name => '$firstName $lastName';

  factory PatientEntity.empty() => PatientEntity(
        id: '',
        doctorId: '',
        firstName: '',
        lastName: '',
        gender: 'Male',
        dateOfBirth: DateTime.now(),
        nationality: '',
        maritalStatus: 'Single',
        occupation: '',
        contactNumber: '',
        emergencyContactName: '',
        emergencyContactPhone: '',
        emergencyContactRelationship: '',
        bloodType: 'O+',
        hasHeartCondition: false,
        hasDiabetes: false,
        hasAsthma: false,
        hasHighBloodPressure: false,
        hasSurgicalHistory: false,
        isTakingMedication: false,
        smokingStatus: 'Never',
        alcoholConsumption: 'None',
        physicalActivityLevel: 'Sedentary',
        height: 0.0,
        weight: 0.0,
        consentToTreatment: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}

@freezed
abstract class VisitEntity with _$VisitEntity {
  const factory VisitEntity({
    required String id,
    required DateTime date,
    required String assessment,
    required String diagnosis,
    required String prescription,
    String? notes,
    @Default([]) List<MedicalReportEntity> reports,
  }) = _VisitEntity;
}

@freezed
abstract class MedicalReportEntity with _$MedicalReportEntity {
  const factory MedicalReportEntity({
    required String id,
    required String name,
    required String fileUrl,
    required DateTime date,
    required String type, // e.g., "X-RAY", "BLOOD_TEST"
  }) = _MedicalReportEntity;
}
