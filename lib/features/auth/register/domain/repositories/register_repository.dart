import 'package:dartz/dartz.dart';

abstract class IRegisterRepository {
  Future<Either<String, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });
}
