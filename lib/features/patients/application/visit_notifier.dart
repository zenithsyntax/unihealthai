import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import '../../../../core/utils/failure.dart';
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

  Future<Either<Failure, Unit>> addVisit(
      String patientId, VisitEntity visit) async {
    state = state.copyWith(isLoading: true, failureOrSuccessOption: none());
    final repository = ref.read(patientRepositoryProvider);
    final result = await repository.addVisit(patientId, visit);

    return result.fold(
      (failure) {
        state = state.copyWith(
            isLoading: false, failureOrSuccessOption: some(failure));
        return Left(failure);
      },
      (_) async {
        await getVisits(patientId);
        return const Right(unit);
      },
    );
  }

  Future<Either<Failure, Unit>> updateVisit(
      String patientId, VisitEntity visit) async {
    state = state.copyWith(isLoading: true, failureOrSuccessOption: none());
    final repository = ref.read(patientRepositoryProvider);
    final result = await repository.updateVisit(patientId, visit);

    return result.fold(
      (failure) {
        state = state.copyWith(
            isLoading: false, failureOrSuccessOption: some(failure));
        return Left(failure);
      },
      (_) async {
        await getVisits(patientId);
        return const Right(unit);
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
