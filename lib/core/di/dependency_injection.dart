import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/patients/domain/repositories/i_patient_repository.dart';
import '../../features/patients/infrastructure/repositories/patient_repository.dart';
import 'package:unihealthai/features/auth/login/domain/repositories/login_repository.dart';
import 'package:unihealthai/features/auth/login/infrastructure/repositories/login_repository_impl.dart';
import 'package:unihealthai/features/auth/register/domain/repositories/register_repository.dart';
import 'package:unihealthai/features/auth/register/infrastructure/repositories/register_repository_impl.dart';

// Firebase Providers
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firebaseStorageProvider = Provider<FirebaseStorage>((ref) {
  return FirebaseStorage.instance;
});

// Repository Providers

final patientRepositoryProvider = Provider<IPatientRepository>((ref) {
  return PatientRepository(
    ref.watch(firestoreProvider),
    ref.watch(firebaseStorageProvider),
  );
});

final loginRepositoryProvider = Provider<ILoginRepository>((ref) {
  return LoginRepositoryImpl(
    ref.watch(firebaseAuthProvider),
    ref.watch(sharedPreferencesProvider),
  );
});

final registerRepositoryProvider = Provider<IRegisterRepository>((ref) {
  return RegisterRepositoryImpl(
    ref.watch(firebaseAuthProvider),
    ref.watch(firestoreProvider),
  );
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});
