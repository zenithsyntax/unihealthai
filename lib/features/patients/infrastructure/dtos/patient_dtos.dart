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
    required String name,
    required int age,
    required String gender,
    required String contactNumber,
    @Default([]) List<VisitDto> visits,
  }) = _PatientDto;

  factory PatientDto.fromJson(Map<String, dynamic> json) =>
      _$PatientDtoFromJson(json);

  factory PatientDto.fromDomain(PatientEntity patient) {
    return PatientDto(
      id: patient.id,
      doctorId: patient.doctorId,
      name: patient.name,
      age: patient.age,
      gender: patient.gender,
      contactNumber: patient.contactNumber,
      visits: patient.visits.map((e) => VisitDto.fromDomain(e)).toList(),
    );
  }

  PatientEntity toDomain() {
    return PatientEntity(
      id: id ?? '',
      doctorId: doctorId,
      name: name,
      age: age,
      gender: gender,
      contactNumber: contactNumber,
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
