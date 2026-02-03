import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:unihealthai/features/patients/domain/entities/patient_entity.dart';
import '../../../../core/utils/failure.dart';

part 'patient_state.freezed.dart';

@freezed
class PatientState with _$PatientState {
  const factory PatientState.initial() = _Initial;
  const factory PatientState.loading() = _Loading;
  const factory PatientState.success(List<PatientEntity> patients) = _Success;
  const factory PatientState.failure(Failure failure) = _Failure;
}
