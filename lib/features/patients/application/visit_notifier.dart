import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:unihealthai/core/di/dependency_injection.dart';

import '../domain/entities/patient_entity.dart';
import 'visit_state.dart';

class VisitNotifier extends Notifier<VisitState> {
  @override
  VisitState build() {
    return VisitState.initial();
  }

  Future<void> getVisits(String patientId) async {
    state = state.copyWith(isLoading: true, failureOrSuccessOption: none());
    final repository = ref.read(patientRepositoryProvider);
    final result = await repository.getVisits(patientId);
    state = result.fold(
      (failure) => state.copyWith(
          isLoading: false, failureOrSuccessOption: some(failure)),
      (visits) => state.copyWith(
          isLoading: false, visits: visits, failureOrSuccessOption: none()),
    );
  }

  Future<void> addVisit(String patientId, VisitEntity visit) async {
    state = state.copyWith(isLoading: true, failureOrSuccessOption: none());
    final repository = ref.read(patientRepositoryProvider);
    final result = await repository.addVisit(patientId, visit);

    result.fold(
      (failure) => state = state.copyWith(
          isLoading: false, failureOrSuccessOption: some(failure)),
      (_) async {
        // Should we set success here?
        // For add/update, we might want to show a snackbar.
        // But we refresh the list immediately.
        // Let's set success failureOrSuccessOption is for *failure*.
        // If we want to signal success, we might need another field or use Option<Either<Failure, Unit>>.
        // For now, let's just clear failure.
        await getVisits(patientId);
      },
    );
  }

  Future<void> updateVisit(String patientId, VisitEntity visit) async {
    state = state.copyWith(isLoading: true, failureOrSuccessOption: none());
    final repository = ref.read(patientRepositoryProvider);
    final result = await repository.updateVisit(patientId, visit);

    result.fold(
      (failure) => state = state.copyWith(
          isLoading: false, failureOrSuccessOption: some(failure)),
      (_) async {
        await getVisits(patientId);
      },
    );
  }

  Future<Either<String, String>> uploadReport(Uint8List fileBytes,
      String fileName, String patientId, String visitId) async {
    final repository = ref.read(patientRepositoryProvider);
    final result = await repository.uploadMedicalReport(
        fileBytes, fileName, patientId, visitId);
    return result.fold((l) => Left(l.message), (r) => Right(r));
  }
}

final visitNotifierProvider = NotifierProvider<VisitNotifier, VisitState>(() {
  return VisitNotifier();
});
