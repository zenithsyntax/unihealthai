import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/utils/failure.dart';
import '../../domain/entities/patient_entity.dart';
import '../../domain/repositories/i_patient_repository.dart';
import '../dtos/patient_dtos.dart';

class PatientRepository implements IPatientRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  PatientRepository(this._firestore, this._storage);

  @override
  Future<Either<Failure, List<PatientEntity>>> getPatients(
      String doctorId) async {
    try {
      final snapshot = await _firestore
          .collection('patients')
          .where('doctorId', isEqualTo: doctorId)
          .get();

      final patients = snapshot.docs
          .map((doc) => PatientDto.fromFirestore(doc).toDomain())
          .toList();

      return Right(patients);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VisitEntity>>> getVisits(String patientId) async {
    try {
      final snapshot = await _firestore
          .collection('patients')
          .doc(patientId)
          .collection('visits')
          .orderBy('date', descending: true)
          .get();

      final visits = snapshot.docs
          .map((doc) => VisitDto.fromFirestore(doc).toDomain())
          .toList();

      return Right(visits);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addPatient(PatientEntity patient) async {
    try {
      final patientDto = PatientDto.fromDomain(patient);
      await _firestore
          .collection('patients')
          .doc(patient.id.isEmpty ? null : patient.id)
          .set(patientDto.toJson());
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addVisit(
      String patientId, VisitEntity visit) async {
    try {
      final visitDto = VisitDto.fromDomain(visit);

      // Use subcollection 'visits'
      final docRef = _firestore
          .collection('patients')
          .doc(patientId)
          .collection('visits')
          .doc(visit.id.isEmpty ? null : visit.id);

      // Ensure the ID is set if it was empty
      final visitToSave = visitDto.copyWith(id: docRef.id);

      await docRef.set(visitToSave.toJson());

      // Optional: Update patient's "last visit" or similar summary field if needed
      // But for now, we just add to subcollection.

      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateVisit(
      String patientId, VisitEntity visit) async {
    try {
      final visitDto = VisitDto.fromDomain(visit);

      await _firestore
          .collection('patients')
          .doc(patientId)
          .collection('visits')
          .doc(visit.id)
          .update(visitDto.toJson());

      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadMedicalReport(Uint8List fileBytes,
      String fileName, String patientId, String visitId) async {
    try {
      final ref = _storage.ref().child(
          'medical_reports/$patientId/$visitId/${DateTime.now().millisecondsSinceEpoch}_$fileName');
      String mimeType = 'application/octet-stream';
      if (fileName.toLowerCase().endsWith('.pdf')) {
        mimeType = 'application/pdf';
      } else if (fileName.toLowerCase().endsWith('.jpg') ||
          fileName.toLowerCase().endsWith('.jpeg')) {
        mimeType = 'image/jpeg';
      } else if (fileName.toLowerCase().endsWith('.png')) {
        mimeType = 'image/png';
      }

      final metadata = SettableMetadata(
        contentType: mimeType,
      );
      final uploadTask = await ref.putData(fileBytes, metadata);
      final url = await uploadTask.ref.getDownloadURL();
      return Right(url);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
