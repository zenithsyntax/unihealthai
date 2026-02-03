import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_entity.freezed.dart';

@freezed
abstract class PatientEntity with _$PatientEntity {
  const factory PatientEntity({
    required String id,
    required String doctorId,
    required String name,
    required int age,
    required String gender,
    required String contactNumber,
    @Default([]) List<VisitEntity> visits,
  }) = _PatientEntity;

  factory PatientEntity.empty() => const PatientEntity(
        id: '',
        doctorId: '',
        name: '',
        age: 0,
        gender: '',
        contactNumber: '',
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
