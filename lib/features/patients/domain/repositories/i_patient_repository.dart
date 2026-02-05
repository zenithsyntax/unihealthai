import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/failure.dart';
import '../entities/patient_entity.dart';

abstract class IPatientRepository {
  Future<Either<Failure, List<PatientEntity>>> getPatients(String doctorId);
  Future<Either<Failure, List<VisitEntity>>> getVisits(String patientId);
  Future<Either<Failure, Unit>> addPatient(PatientEntity patient);
  Future<Either<Failure, Unit>> addVisit(String patientId, VisitEntity visit);
  Future<Either<Failure, Unit>> updateVisit(
      String patientId, VisitEntity visit);
  Future<Either<Failure, String>> uploadMedicalReport(
      Uint8List fileBytes, String fileName, String patientId, String visitId);
  Future<Either<Failure, Unit>> deletePatient(String patientId);
}
