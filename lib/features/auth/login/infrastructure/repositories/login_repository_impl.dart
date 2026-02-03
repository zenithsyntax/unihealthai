import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements ILoginRepository {
  final FirebaseAuth _firebaseAuth;
  final SharedPreferences _sharedPreferences;

  LoginRepositoryImpl(this._firebaseAuth, this._sharedPreferences);

  @override
  Future<Either<String, Unit>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        // Save credentials/token to SharedPreferences
        await _sharedPreferences.setString(
            'auth_token', await user.getIdToken() ?? '');
        await _sharedPreferences.setString('uid', user.uid);
        // You might want to save more info or just a flag
        await _sharedPreferences.setBool('is_logged_in', true);

        return right(unit);
      } else {
        return left('Login failed: User is null');
      }
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'An error occurred during login');
    } catch (e) {
      return left(e.toString());
    }
  }
}
