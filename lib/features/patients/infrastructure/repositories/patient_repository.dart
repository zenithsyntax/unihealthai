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

      final patientsWithVisits =
          await Future.wait(patients.map((patient) async {
        try {
          final visitsSnapshot = await _firestore
              .collection('patients')
              .doc(patient.id)
              .collection('visits')
              .orderBy('date', descending: true)
              .limit(1)
              .get();

          if (visitsSnapshot.docs.isNotEmpty) {
            final latestVisit =
                VisitDto.fromFirestore(visitsSnapshot.docs.first).toDomain();
            return patient.copyWith(visits: [latestVisit]);
          }
        } catch (e) {
          // Ignore visit fetch errors to avoid blocking patient list
          print('Error fetching visits for ${patient.id}: $e');
        }
        return patient;
      }));

      return Right(patientsWithVisits);
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
      final json = Map<String, dynamic>.from(patientDto.toJson());
      json.remove('visits');
      await _firestore
          .collection('patients')
          .doc(patient.id.isEmpty ? null : patient.id)
          .set(json);
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

      final visitJson = visitToSave.toJson();
      // Manually convert reports to list of maps because the generated toJson
      // might not handle it if explicit_to_json is not enabled in generator
      // and we cannot run build_runner easily.
      if (visitToSave.reports.isNotEmpty) {
        visitJson['reports'] =
            visitToSave.reports.map((e) => e.toJson()).toList();
      }

      await docRef.set(visitJson);

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
      final visitJson = visitDto.toJson();
      if (visitDto.reports.isNotEmpty) {
        visitJson['reports'] = visitDto.reports.map((e) => e.toJson()).toList();
      }

      await _firestore
          .collection('patients')
          .doc(patientId)
          .collection('visits')
          .doc(visit.id)
          .update(visitJson);

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

  @override
  Future<Either<Failure, Unit>> updatePatient(PatientEntity patient) async {
    try {
      final patientDto = PatientDto.fromDomain(patient);
      final json = Map<String, dynamic>.from(patientDto.toJson());
      json.remove('visits');
      await _firestore.collection('patients').doc(patient.id).update(json);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePatient(String patientId) async {
    try {
      await _firestore.collection('patients').doc(patientId).delete();
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
