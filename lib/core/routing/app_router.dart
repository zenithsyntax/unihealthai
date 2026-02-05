import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/login/presentation/login_screen.dart';
import '../../features/auth/register/presentation/register_screen.dart';
import '../di/dependency_injection.dart';
import '../../features/patients/presentation/screens/doctor_dashboard_screen.dart';
import '../../features/patients/presentation/screens/patient_details_screen.dart';
import '../../features/patients/presentation/screens/add_patient_screen.dart';
import '../../features/patients/domain/entities/patient_entity.dart';

// Provides the global generic GoRouter instance
final routerProvider = Provider<GoRouter>((ref) {
  final authStateAsync = ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshStream(
        ref.watch(firebaseAuthProvider).authStateChanges()),
    redirect: (context, state) {
      final isLoggingIn = state.uri.toString() == '/login';
      final isRegistering = state.uri.toString() == '/register';
      final isLoggedIn = authStateAsync.value != null;

      if (!isLoggedIn && !isLoggingIn && !isRegistering) {
        return '/login';
      }

      if (isLoggedIn && (isLoggingIn || isRegistering)) {
        return '/';
      }

      return null;
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return SelectionArea(
            child: child,
          );
        },
        routes: [
          GoRoute(
              path: '/login', builder: (context, state) => const LoginScreen()),
          GoRoute(
              path: '/register',
              builder: (context, state) => const RegisterScreen()),
          GoRoute(
            path: '/',
            builder: (context, state) => const DoctorDashboardScreen(),
          ),
          GoRoute(
            path: '/patient-details',
            builder: (context, state) {
              final patient = state.extra as PatientEntity;
              return PatientDetailsScreen(patient: patient);
            },
          ),
          GoRoute(
            path: '/add-patient',
            builder: (context, state) => const AddPatientScreen(),
          ),
        ],
      ),
    ],
  );
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
