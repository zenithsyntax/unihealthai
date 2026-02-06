import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart'; // Added import
import '../../../../core/di/dependency_injection.dart';
import '../../application/patient_notifier.dart';
import '../../application/patient_state.dart';
import '../../domain/entities/patient_entity.dart';
import '../../../../core/theme/app_theme.dart';

class DoctorDashboardScreen extends ConsumerStatefulWidget {
  const DoctorDashboardScreen({super.key});

  @override
  ConsumerState<DoctorDashboardScreen> createState() =>
      _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends ConsumerState<DoctorDashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final user = ref.read(firebaseAuthProvider).currentUser;
      if (user != null) {
        ref.read(patientNotifierProvider.notifier).getPatients(user.uid);
      }
    });

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patientState = ref.watch(patientNotifierProvider);

    return SelectionArea(
      child: Scaffold(
        backgroundColor: AppTheme.backgroundLight,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildSliverAppBar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWelcomeSection(patientState),
                      const SizedBox(height: 24),
                      _buildSectionHeader('My Patients'),
                      const SizedBox(height: 16),
                      _buildSearchField(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              _buildPatientList(patientState),
              const SliverToBoxAdapter(
                  child: SizedBox(height: 80)), // Padding for FAB
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.push('/add-patient');
          },
          backgroundColor: AppTheme.primaryGreen,
          icon: const Icon(Icons.add_rounded, color: Colors.white),
          label: Text('Add Patient',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          elevation: 4,
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: AppTheme.backgroundLight,
      surfaceTintColor: Colors.transparent,
      floating: true,
      elevation: 0,
      centerTitle: false,
      expandedHeight: 70,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryGreen,
                  const Color(0xFF0D47A1)
                ], // Professional Blue-Green
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryGreen.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.local_hospital_rounded,
                color: Colors.white, size: 24),
          ),
          const SizedBox(width: 14),
          Text(
            'UniHealthAI',
            style: GoogleFonts.outfit(
              color: AppTheme.textDark,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton.filledTonal(
            icon: const Icon(Icons.logout_rounded, color: AppTheme.errorRed),
            style: IconButton.styleFrom(
              backgroundColor: AppTheme.errorRed.withOpacity(0.1),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await ref.read(firebaseAuthProvider).signOut();
                      },
                      child: const Text('Logout',
                          style: TextStyle(color: AppTheme.errorRed)),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildWelcomeSection(PatientState state) {
    final now = DateTime.now();
    final dateString = DateFormat('EEEE, d MMMM').format(now).toUpperCase();

    // Calculate stats
    final totalPatients =
        state.maybeWhen(success: (p) => p.length.toString(), orElse: () => '-');
    final criticalPatients = state.maybeWhen(
        success: (p) => p
            .where((i) =>
                i.hasDiabetes || i.hasHeartCondition || i.hasHighBloodPressure)
            .length
            .toString(),
        orElse: () => '-');

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateString,
                  style: GoogleFonts.poppins(
                    color: AppTheme.textGrey,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Good Day,\nDoctor',
                  style: GoogleFonts.poppins(
                    color: AppTheme.textDark,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                    letterSpacing: -0.5,
                  ),
                ).animate().fadeIn().slideX(begin: -0.1),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppTheme.textDark,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: 'Search patients...',
          hintStyle: GoogleFonts.poppins(
              color: Colors.grey[400], fontWeight: FontWeight.normal),
          prefixIcon: Icon(Icons.search_rounded, color: AppTheme.primaryGreen),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildPatientList(PatientState state) {
    return state.when(
      initial: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
      failure: (failure) => SliverFillRemaining(
        child: Center(child: Text('Error: ${failure.message}')),
      ),
      success: (patients) {
        final filteredPatients = patients.where((patient) {
          final name = patient.name.toLowerCase();
          return name.contains(_searchQuery);
        }).toList();

        if (filteredPatients.isEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_off_outlined,
                      size: 48, color: AppTheme.textGrey),
                  SizedBox(height: 16),
                  Text(
                    'No patients found',
                    style: TextStyle(color: AppTheme.textGrey),
                  ),
                ],
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final patient = filteredPatients[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: _buildPatientCard(context, patient)
                    .animate(delay: (50 * index).ms)
                    .fadeIn()
                    .slideY(begin: 0.1),
              );
            },
            childCount: filteredPatients.length,
          ),
        );
      },
    );
  }

  Widget _buildPatientCard(BuildContext context, PatientEntity patient) {
    // Determine last visit
    String lastVisit = 'No visits yet';
    if (patient.visits.isNotEmpty) {
      final latest = patient.visits
          .reduce((curr, next) => curr.date.isAfter(next.date) ? curr : next);
      lastVisit = DateFormat('MMM d, yyyy').format(latest.date);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          // Header: Avatar + Name + Basic Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Hero(
                  tag: 'avatar_${patient.id}',
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.primaryGreen.withOpacity(0.3),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryGreen.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        patient.name.isNotEmpty
                            ? patient.name.substring(0, 1).toUpperCase()
                            : '?',
                        style: GoogleFonts.poppins(
                          color: AppTheme.primaryGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient.name,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${patient.age} yrs',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textGrey,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: patient.gender.toLowerCase() == 'male'
                                  ? Colors.blue.withOpacity(0.1)
                                  : Colors.pink.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              patient.gender,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: patient.gender.toLowerCase() == 'male'
                                    ? Colors.blue[700]
                                    : Colors.pink[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: AppTheme.textGrey),
                  onSelected: (value) {
                    if (value == 'edit') {
                      context.push('/add-patient', extra: patient);
                    } else if (value == 'delete') {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Patient'),
                          content: Text(
                              'Are you sure you want to delete ${patient.name}?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                ref
                                    .read(patientNotifierProvider.notifier)
                                    .deletePatient(patient.id);
                                Navigator.pop(context);
                              },
                              child: const Text('Delete',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(children: [
                        Icon(Icons.edit, size: 18),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ]),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(children: [
                        Icon(Icons.delete, color: Colors.red, size: 18),
                        SizedBox(width: 8),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),

          // 3. Medical Tags & Diagnosis Section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Medical Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (patient.hasDiabetes)
                      _buildMedicalTag('Diabetes', Colors.orange),
                    if (patient.hasHeartCondition)
                      _buildMedicalTag('Heart', Colors.red),
                    if (patient.hasAsthma)
                      _buildMedicalTag('Asthma', Colors.purple),
                    if (patient.hasHighBloodPressure)
                      _buildMedicalTag('High BP', Colors.redAccent),
                    if (!patient.hasDiabetes &&
                        !patient.hasHeartCondition &&
                        !patient.hasAsthma &&
                        !patient.hasHighBloodPressure)
                      _buildMedicalTag('No Chronic Conditions', Colors.green),
                  ],
                ),
                const SizedBox(height: 16),

                // Latest Diagnosis (if visits exist)
                if (patient.visits.isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('LATEST DIAGNOSIS',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textGrey,
                                      letterSpacing: 1)),
                              const SizedBox(height: 4),
                              Text(
                                patient.visits
                                    .reduce((curr, next) =>
                                        curr.date.isAfter(next.date)
                                            ? curr
                                            : next)
                                    .diagnosis,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textDark),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.2)),
                          ),
                          child: Text(
                            lastVisit,
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textGrey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),

          // Actions Row (View)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.tonal(
                onPressed: () {
                  context.push('/patient-details', extra: patient);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen.withOpacity(0.1),
                  foregroundColor: AppTheme.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('View Patient Details',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}
