// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PatientDto _$PatientDtoFromJson(Map<String, dynamic> json) => _PatientDto(
      id: json['id'] as String?,
      doctorId: json['doctorId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      nationality: json['nationality'] as String,
      maritalStatus: json['maritalStatus'] as String,
      occupation: json['occupation'] as String,
      contactNumber: json['contactNumber'] as String,
      emergencyContactName: json['emergencyContactName'] as String,
      emergencyContactPhone: json['emergencyContactPhone'] as String,
      emergencyContactRelationship:
          json['emergencyContactRelationship'] as String,
      bloodType: json['bloodType'] as String,
      hasHeartCondition: json['hasHeartCondition'] as bool,
      hasDiabetes: json['hasDiabetes'] as bool,
      hasAsthma: json['hasAsthma'] as bool,
      hasHighBloodPressure: json['hasHighBloodPressure'] as bool,
      hasSurgicalHistory: json['hasSurgicalHistory'] as bool,
      surgeryDetails: json['surgeryDetails'] as String?,
      familyMedicalHistory: json['familyMedicalHistory'] as String?,
      isTakingMedication: json['isTakingMedication'] as bool,
      currentMedications: json['currentMedications'] as String?,
      drugAllergyDetails: json['drugAllergyDetails'] as String?,
      foodAllergyDetails: json['foodAllergyDetails'] as String?,
      mentalHealthNotes: json['mentalHealthNotes'] as String?,
      smokingStatus: json['smokingStatus'] as String,
      alcoholConsumption: json['alcoholConsumption'] as String,
      physicalActivityLevel: json['physicalActivityLevel'] as String,
      sleepHoursPerNight: (json['sleepHoursPerNight'] as num?)?.toInt(),
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      bmi: (json['bmi'] as num?)?.toDouble(),
      restingHeartRate: (json['restingHeartRate'] as num?)?.toInt(),
      bloodPressure: json['bloodPressure'] as String?,
      insuranceProvider: json['insuranceProvider'] as String?,
      insurancePolicyNumber: json['insurancePolicyNumber'] as String?,
      consentToTreatment: json['consentToTreatment'] as bool,
      consentDate: json['consentDate'] == null
          ? null
          : DateTime.parse(json['consentDate'] as String),
      notes: json['notes'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      additionalDocuments: (json['additionalDocuments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      visits: (json['visits'] as List<dynamic>?)
              ?.map((e) => VisitDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PatientDtoToJson(_PatientDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorId': instance.doctorId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'nationality': instance.nationality,
      'maritalStatus': instance.maritalStatus,
      'occupation': instance.occupation,
      'contactNumber': instance.contactNumber,
      'emergencyContactName': instance.emergencyContactName,
      'emergencyContactPhone': instance.emergencyContactPhone,
      'emergencyContactRelationship': instance.emergencyContactRelationship,
      'bloodType': instance.bloodType,
      'hasHeartCondition': instance.hasHeartCondition,
      'hasDiabetes': instance.hasDiabetes,
      'hasAsthma': instance.hasAsthma,
      'hasHighBloodPressure': instance.hasHighBloodPressure,
      'hasSurgicalHistory': instance.hasSurgicalHistory,
      'surgeryDetails': instance.surgeryDetails,
      'familyMedicalHistory': instance.familyMedicalHistory,
      'isTakingMedication': instance.isTakingMedication,
      'currentMedications': instance.currentMedications,
      'drugAllergyDetails': instance.drugAllergyDetails,
      'foodAllergyDetails': instance.foodAllergyDetails,
      'mentalHealthNotes': instance.mentalHealthNotes,
      'smokingStatus': instance.smokingStatus,
      'alcoholConsumption': instance.alcoholConsumption,
      'physicalActivityLevel': instance.physicalActivityLevel,
      'sleepHoursPerNight': instance.sleepHoursPerNight,
      'height': instance.height,
      'weight': instance.weight,
      'bmi': instance.bmi,
      'restingHeartRate': instance.restingHeartRate,
      'bloodPressure': instance.bloodPressure,
      'insuranceProvider': instance.insuranceProvider,
      'insurancePolicyNumber': instance.insurancePolicyNumber,
      'consentToTreatment': instance.consentToTreatment,
      'consentDate': instance.consentDate?.toIso8601String(),
      'notes': instance.notes,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'additionalDocuments': instance.additionalDocuments,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'visits': instance.visits,
    };

_VisitDto _$VisitDtoFromJson(Map<String, dynamic> json) => _VisitDto(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      assessment: json['assessment'] as String,
      diagnosis: json['diagnosis'] as String,
      prescription: json['prescription'] as String,
      notes: json['notes'] as String?,
      reports: (json['reports'] as List<dynamic>?)
              ?.map((e) => MedicalReportDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$VisitDtoToJson(_VisitDto instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'assessment': instance.assessment,
      'diagnosis': instance.diagnosis,
      'prescription': instance.prescription,
      'notes': instance.notes,
      'reports': instance.reports,
    };

_MedicalReportDto _$MedicalReportDtoFromJson(Map<String, dynamic> json) =>
    _MedicalReportDto(
      id: json['id'] as String,
      name: json['name'] as String,
      fileUrl: json['fileUrl'] as String,
      date: DateTime.parse(json['date'] as String),
      type: json['type'] as String,
    );

Map<String, dynamic> _$MedicalReportDtoToJson(_MedicalReportDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fileUrl': instance.fileUrl,
      'date': instance.date.toIso8601String(),
      'type': instance.type,
    };
