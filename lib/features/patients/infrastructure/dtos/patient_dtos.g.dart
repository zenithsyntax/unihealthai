// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PatientDto _$PatientDtoFromJson(Map<String, dynamic> json) => _PatientDto(
      id: json['id'] as String?,
      doctorId: json['doctorId'] as String,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      gender: json['gender'] as String,
      contactNumber: json['contactNumber'] as String,
      visits: (json['visits'] as List<dynamic>?)
              ?.map((e) => VisitDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PatientDtoToJson(_PatientDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorId': instance.doctorId,
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'contactNumber': instance.contactNumber,
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
