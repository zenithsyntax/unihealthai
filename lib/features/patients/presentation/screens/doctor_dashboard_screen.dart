import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../application/patient_notifier.dart';
import '../../application/patient_state.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/dependency_injection.dart';

class DoctorDashboardScreen extends ConsumerStatefulWidget {
  const DoctorDashboardScreen({super.key});

  @override
  ConsumerState<DoctorDashboardScreen> createState() =>
      _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends ConsumerState<DoctorDashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch patients on init
    // We need the doctorId. Assuming the auth state has the user info.
    Future.microtask(() {
      final user = ref.read(firebaseAuthProvider).currentUser;
      if (user != null) {
        ref.read(patientNotifierProvider.notifier).getPatients(user.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final patientState = ref.watch(patientNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(firebaseAuthProvider).signOut();
            },
          )
        ],
      ),
      body: patientState.when(
        initial: () =>
            const Center(child: Text('Welcome! Loading patients...')),
        loading: () => const Center(child: CircularProgressIndicator()),
        success: (patients) {
          if (patients.isEmpty) {
            return const Center(child: Text('No patients found. Add one!'));
          }
          return ListView.builder(
            itemCount: patients.length,
            itemBuilder: (context, index) {
              final patient = patients[index];
              return ListTile(
                title: Text(patient.name),
                subtitle: Text('Age: ${patient.age} | ${patient.gender}'),
                onTap: () {
                  context.push('/patient-details', extra: patient);
                },
              );
            },
          );
        },
        failure: (failure) => Center(child: Text('Error: ${failure.message}')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add-patient');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
