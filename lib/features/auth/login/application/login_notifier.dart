import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/dependency_injection.dart';
import 'login_state.dart';

final loginNotifierProvider =
    NotifierProvider<LoginNotifier, LoginState>(LoginNotifier.new);

class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() {
    return const LoginState();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state =
        state.copyWith(isLoading: true, errorMessage: null, isSuccess: false);

    final repository = ref.read(loginRepositoryProvider);

    final result = await repository.loginWithEmailAndPassword(
      email: email,
      password: password,
    );

    state = result.fold(
      (failure) => state.copyWith(isLoading: false, errorMessage: failure),
      (_) => state.copyWith(isLoading: false, isSuccess: true),
    );
  }
}
