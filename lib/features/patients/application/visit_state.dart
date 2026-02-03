import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/failure.dart';
import '../domain/entities/patient_entity.dart';

part 'visit_state.freezed.dart';

@freezed
abstract class VisitState with _$VisitState {
  const factory VisitState({
    @Default(false) bool isLoading,
    @Default([]) List<VisitEntity> visits,
    @Default(None()) Option<Failure> failureOrSuccessOption,
  }) = _VisitState;

  factory VisitState.initial() => const VisitState();
}
