import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/patient_entity.dart';

part 'patient_dtos.freezed.dart';
part 'patient_dtos.g.dart';

@freezed
abstract class PatientDto with _$PatientDto {
  const PatientDto._();

  const factory PatientDto({
    String? id,
    required String doctorId,
    required String firstName,
    required String lastName,
    required String gender,
    required DateTime dateOfBirth,
    required String nationality,
    required String maritalStatus,
    required String occupation,
    required String contactNumber,
    required String emergencyContactName,
    required String emergencyContactPhone,
    required String emergencyContactRelationship,
    required String bloodType,
    required bool hasHeartCondition,
    required bool hasDiabetes,
    required bool hasAsthma,
    required bool hasHighBloodPressure,
    required bool hasSurgicalHistory,
    String? surgeryDetails,
    String? familyMedicalHistory,
    required bool isTakingMedication,
    String? currentMedications,
    String? drugAllergyDetails,
    String? foodAllergyDetails,
    String? mentalHealthNotes,
    required String smokingStatus,
    required String alcoholConsumption,
    required String physicalActivityLevel,
    int? sleepHoursPerNight,
    required double height,
    required double weight,
    double? bmi,
    int? restingHeartRate,
    String? bloodPressure,
    String? insuranceProvider,
    String? insurancePolicyNumber,
    required bool consentToTreatment,
    DateTime? consentDate,
    String? notes,
    String? profilePhotoUrl,
    @Default([]) List<String> additionalDocuments,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<VisitDto> visits,
  }) = _PatientDto;

  factory PatientDto.fromJson(Map<String, dynamic> json) =>
      _$PatientDtoFromJson(json);

  factory PatientDto.fromDomain(PatientEntity patient) {
    return PatientDto(
      id: patient.id,
      doctorId: patient.doctorId,
      firstName: patient.firstName,
      lastName: patient.lastName,
      gender: patient.gender,
      dateOfBirth: patient.dateOfBirth,
      nationality: patient.nationality,
      maritalStatus: patient.maritalStatus,
      occupation: patient.occupation,
      contactNumber: patient.contactNumber,
      emergencyContactName: patient.emergencyContactName,
      emergencyContactPhone: patient.emergencyContactPhone,
      emergencyContactRelationship: patient.emergencyContactRelationship,
      bloodType: patient.bloodType,
      hasHeartCondition: patient.hasHeartCondition,
      hasDiabetes: patient.hasDiabetes,
      hasAsthma: patient.hasAsthma,
      hasHighBloodPressure: patient.hasHighBloodPressure,
      hasSurgicalHistory: patient.hasSurgicalHistory,
      surgeryDetails: patient.surgeryDetails,
      familyMedicalHistory: patient.familyMedicalHistory,
      isTakingMedication: patient.isTakingMedication,
      currentMedications: patient.currentMedications,
      drugAllergyDetails: patient.drugAllergyDetails,
      foodAllergyDetails: patient.foodAllergyDetails,
      mentalHealthNotes: patient.mentalHealthNotes,
      smokingStatus: patient.smokingStatus,
      alcoholConsumption: patient.alcoholConsumption,
      physicalActivityLevel: patient.physicalActivityLevel,
      sleepHoursPerNight: patient.sleepHoursPerNight,
      height: patient.height,
      weight: patient.weight,
      bmi: patient.bmi,
      restingHeartRate: patient.restingHeartRate,
      bloodPressure: patient.bloodPressure,
      insuranceProvider: patient.insuranceProvider,
      insurancePolicyNumber: patient.insurancePolicyNumber,
      consentToTreatment: patient.consentToTreatment,
      consentDate: patient.consentDate,
      notes: patient.notes,
      profilePhotoUrl: patient.profilePhotoUrl,
      additionalDocuments: patient.additionalDocuments,
      createdAt: patient.createdAt,
      updatedAt: patient.updatedAt,
      visits: patient.visits.map((e) => VisitDto.fromDomain(e)).toList(),
    );
  }

  PatientEntity toDomain() {
    return PatientEntity(
      id: id ?? '',
      doctorId: doctorId,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      dateOfBirth: dateOfBirth,
      nationality: nationality,
      maritalStatus: maritalStatus,
      occupation: occupation,
      contactNumber: contactNumber,
      emergencyContactName: emergencyContactName,
      emergencyContactPhone: emergencyContactPhone,
      emergencyContactRelationship: emergencyContactRelationship,
      bloodType: bloodType,
      hasHeartCondition: hasHeartCondition,
      hasDiabetes: hasDiabetes,
      hasAsthma: hasAsthma,
      hasHighBloodPressure: hasHighBloodPressure,
      hasSurgicalHistory: hasSurgicalHistory,
      surgeryDetails: surgeryDetails,
      familyMedicalHistory: familyMedicalHistory,
      isTakingMedication: isTakingMedication,
      currentMedications: currentMedications,
      drugAllergyDetails: drugAllergyDetails,
      foodAllergyDetails: foodAllergyDetails,
      mentalHealthNotes: mentalHealthNotes,
      smokingStatus: smokingStatus,
      alcoholConsumption: alcoholConsumption,
      physicalActivityLevel: physicalActivityLevel,
      sleepHoursPerNight: sleepHoursPerNight,
      height: height,
      weight: weight,
      bmi: bmi,
      restingHeartRate: restingHeartRate,
      bloodPressure: bloodPressure,
      insuranceProvider: insuranceProvider,
      insurancePolicyNumber: insurancePolicyNumber,
      consentToTreatment: consentToTreatment,
      consentDate: consentDate,
      notes: notes,
      profilePhotoUrl: profilePhotoUrl,
      additionalDocuments: additionalDocuments,
      createdAt: createdAt,
      updatedAt: updatedAt,
      visits: visits.map((e) => e.toDomain()).toList(),
    );
  }

  factory PatientDto.fromFirestore(DocumentSnapshot doc) {
    return PatientDto.fromJson(doc.data() as Map<String, dynamic>)
        .copyWith(id: doc.id);
  }
}

@freezed
abstract class VisitDto with _$VisitDto {
  const VisitDto._();

  const factory VisitDto({
    required String id,
    required DateTime date,
    required String assessment,
    required String diagnosis,
    required String prescription,
    String? notes,
    @Default([]) List<MedicalReportDto> reports,
  }) = _VisitDto;

  factory VisitDto.fromJson(Map<String, dynamic> json) =>
      _$VisitDtoFromJson(json);

  factory VisitDto.fromDomain(VisitEntity visit) {
    return VisitDto(
      id: visit.id,
      date: visit.date,
      assessment: visit.assessment,
      diagnosis: visit.diagnosis,
      prescription: visit.prescription,
      notes: visit.notes,
      reports:
          visit.reports.map((e) => MedicalReportDto.fromDomain(e)).toList(),
    );
  }

  factory VisitDto.fromFirestore(DocumentSnapshot doc) {
    return VisitDto.fromJson(doc.data() as Map<String, dynamic>)
        .copyWith(id: doc.id);
  }

  VisitEntity toDomain() {
    return VisitEntity(
      id: id,
      date: date,
      assessment: assessment,
      diagnosis: diagnosis,
      prescription: prescription,
      notes: notes,
      reports: reports.map((e) => e.toDomain()).toList(),
    );
  }
}

@freezed
abstract class MedicalReportDto with _$MedicalReportDto {
  const MedicalReportDto._();

  const factory MedicalReportDto({
    required String id,
    required String name,
    required String fileUrl,
    required DateTime date,
    required String type,
  }) = _MedicalReportDto;

  factory MedicalReportDto.fromJson(Map<String, dynamic> json) =>
      _$MedicalReportDtoFromJson(json);

  factory MedicalReportDto.fromDomain(MedicalReportEntity report) {
    return MedicalReportDto(
      id: report.id,
      name: report.name,
      fileUrl: report.fileUrl,
      date: report.date,
      type: report.type,
    );
  }

  MedicalReportEntity toDomain() {
    return MedicalReportEntity(
      id: id,
      name: name,
      fileUrl: fileUrl,
      date: date,
      type: type,
    );
  }
}
