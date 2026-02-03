import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/repositories/register_repository.dart';
import 'register_state.dart';
import '../../../../core/di/dependency_injection.dart';

final registerNotifierProvider =
    NotifierProvider<RegisterNotifier, RegisterState>(RegisterNotifier.new);

class RegisterNotifier extends Notifier<RegisterState> {
  @override
  RegisterState build() {
    return const RegisterState();
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    state =
        state.copyWith(isLoading: true, errorMessage: null, isSuccess: false);

    final repository = ref.read(registerRepositoryProvider);

    final result = await repository.registerWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );

    state = result.fold(
      (failure) => state.copyWith(isLoading: false, errorMessage: failure),
      (_) => state.copyWith(isLoading: false, isSuccess: true),
    );
  }
}
