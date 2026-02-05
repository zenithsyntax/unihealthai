import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unihealthai/core/di/dependency_injection.dart';
import 'package:unihealthai/features/patients/domain/entities/patient_entity.dart';

import 'patient_state.dart';

class PatientNotifier extends Notifier<PatientState> {
  @override
  PatientState build() {
    return const PatientState.initial();
  }

  Future<void> getPatients(String doctorId) async {
    state = const PatientState.loading();
    final repository = ref.read(patientRepositoryProvider);
    final result = await repository.getPatients(doctorId);
    state = result.fold(
      (failure) => PatientState.failure(failure),
      (patients) => PatientState.success(patients),
    );
  }

  Future<void> addPatient(PatientEntity patient) async {
    final repository = ref.read(patientRepositoryProvider);
    final result = await repository.addPatient(patient);

    result.fold((l) {
      // Handle error, maybe set state to failure or just log
      // For now, sticking to simple logic
      state = PatientState.failure(l);
    }, (r) {
      getPatients(patient.doctorId);
    });
  }

  Future<void> deletePatient(String patientId) async {
    final repository = ref.read(patientRepositoryProvider);
    final result = await repository.deletePatient(patientId);

    result.fold(
      (failure) => state = PatientState.failure(failure),
      (unit) {
        state.maybeWhen(
          success: (patients) {
            final updatedList =
                patients.where((p) => p.id != patientId).toList();
            state = PatientState.success(updatedList);
          },
          orElse: () {},
        );
      },
    );
  }
}

final patientNotifierProvider =
    NotifierProvider<PatientNotifier, PatientState>(() {
  return PatientNotifier();
});
