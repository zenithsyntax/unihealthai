import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/register_repository.dart';
import '../../domain/user_model.dart';

class RegisterRepositoryImpl implements IRegisterRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  RegisterRepositoryImpl(this._firebaseAuth, this._firestore);

  @override
  Future<Either<String, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user != null) {
        final userModel = UserModel(
          uid: user.uid,
          email: email,
          name: name,
        );

        await _firestore.collection('users').doc(user.uid).set({
          ...userModel.toJson(),
          'createdAt': FieldValue.serverTimestamp(),
        });
        return right(unit);
      } else {
        return left('User creation failed');
      }
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'An error occurred during registration');
    } catch (e) {
      return left(e.toString());
    }
  }
}
