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
    }, (r) {
      getPatients(patient.doctorId);
    });
  }
}

final patientNotifierProvider =
    NotifierProvider<PatientNotifier, PatientState>(() {
  return PatientNotifier();
});
