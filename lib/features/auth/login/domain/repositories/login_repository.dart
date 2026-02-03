import 'package:dartz/dartz.dart';

abstract class ILoginRepository {
  Future<Either<String, Unit>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}
