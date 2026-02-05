import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unihealthai/core/theme/app_theme.dart';
import 'package:unihealthai/features/patients/application/visit_notifier.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../domain/entities/patient_entity.dart';
import '../../../chat/presentation/widgets/ai_chat_widget.dart';
import 'add_edit_visit_screen.dart';
import '../../../visit_chat/presentation/screens/visit_chat_screen.dart';

class PatientDetailsScreen extends ConsumerStatefulWidget {
  final PatientEntity patient;

  const PatientDetailsScreen({super.key, required this.patient});

  @override
  ConsumerState<PatientDetailsScreen> createState() =>
      _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends ConsumerState<PatientDetailsScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isChatOpenDesktop = false; // Only used for desktop toggle
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(() {
      ref.read(visitNotifierProvider.notifier).getVisits(widget.patient.id);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: AppTheme.backgroundLight,
          appBar: _buildAppBar(isDesktop),
          endDrawer: isDesktop
              ? null
              : Drawer(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: const SafeArea(child: AIChatWidget()),
                ),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _buildHeader(isDesktop),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.2))),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: AppTheme.primaryGreen,
                        unselectedLabelColor: AppTheme.textGrey,
                        indicatorColor: AppTheme.primaryGreen,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        tabs: const [
                          Tab(text: 'Overview'),
                          Tab(text: 'Visit History'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildOverviewTab(isDesktop),
                          _buildVisitsTab(isDesktop),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Desktop Chat Sidebar
              if (isDesktop && _isChatOpenDesktop) ...[
                Container(
                  width: 1,
                  color: Colors.grey.withOpacity(0.2),
                ),
                SizedBox(
                  width: 400,
                  child: const AIChatWidget(),
                ),
              ],
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditVisitScreen(
                    patientId: widget.patient.id,
                  ),
                ),
              );
            },
            backgroundColor: AppTheme.primaryGreen,
            elevation: 4,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('New Visit',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5)),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(bool isDesktop) {
    return AppBar(
      title: const Text(
        'Patient Details',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
      ),
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: FilledButton.tonalIcon(
            onPressed: () {
              if (isDesktop) {
                setState(() {
                  _isChatOpenDesktop = !_isChatOpenDesktop;
                });
              } else {
                _scaffoldKey.currentState?.openEndDrawer();
              }
            },
            icon: Icon(
                isDesktop && _isChatOpenDesktop
                    ? Icons.chat_bubble
                    : Icons.chat_bubble_outline,
                size: 20),
            label: const Text('AI Assistant'),
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen.withOpacity(0.1),
              foregroundColor: AppTheme.primaryGreen,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(bool isDesktop) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryGreen.withOpacity(0.9),
            const Color(
                0xFF0D47A1), // Deep Blue for a professional medical look
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        isDesktop ? 32 : 24,
        isDesktop ? 32 : 24,
        isDesktop ? 32 : 24,
        isDesktop ? 48 : 36, // Extra padding at bottom
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'patient_avatar_${widget.patient.id}',
                child: Container(
                  width: isDesktop ? 120 : 90,
                  height: isDesktop ? 120 : 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      widget.patient.name.isNotEmpty
                          ? widget.patient.name.substring(0, 1).toUpperCase()
                          : '?',
                      style: TextStyle(
                        fontSize: isDesktop ? 48 : 36,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.patient.name,
                      style: GoogleFonts.poppins(
                        fontSize: isDesktop ? 32 : 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Patient ID: ${widget.patient.id.substring(0, 8).toUpperCase()}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _buildHeaderTag(
                          '${widget.patient.age} Years',
                          Icons.calendar_today,
                          Colors.white.withOpacity(0.2),
                        ),
                        _buildHeaderTag(
                          widget.patient.gender,
                          Icons.person_outline,
                          Colors.white.withOpacity(0.2),
                        ),
                        if (widget.patient.bloodType.isNotEmpty)
                          _buildHeaderTag(
                            widget.patient.bloodType,
                            Icons.bloodtype,
                            Colors.redAccent.withOpacity(0.4),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderTag(String text, IconData icon, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(bool isDesktop) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isDesktop ? 32 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.patient.hasDiabetes ||
              widget.patient.hasHeartCondition ||
              widget.patient.hasHighBloodPressure) ...[
            _buildSectionHeader('Medical Alerts', Icons.warning_amber_rounded),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                if (widget.patient.hasDiabetes)
                  _buildAlertChip('Diabetes', Icons.water_drop),
                if (widget.patient.hasHeartCondition)
                  _buildAlertChip('Heart Condition', Icons.favorite),
                if (widget.patient.hasHighBloodPressure)
                  _buildAlertChip('High Blood Pressure', Icons.speed),
              ],
            ).animate().fadeIn().slideX(begin: -0.1, duration: 400.ms),
            const SizedBox(height: 32),
          ],
          _buildSectionHeader(
              'Physical Statistics', Icons.monitor_weight_outlined),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 800 ? 3 : 2;
              double width =
                  (constraints.maxWidth - (crossAxisCount - 1) * 16) /
                      crossAxisCount;
              // Ensure reasonable minimum width for mobile
              if (constraints.maxWidth < 400) width = constraints.maxWidth;

              List<Widget> cards = [
                _buildInfoCard(
                  'Height',
                  '${widget.patient.height} cm',
                  Icons.height,
                  Colors.teal,
                  width,
                ),
                _buildInfoCard(
                  'Weight',
                  '${widget.patient.weight} kg',
                  Icons.monitor_weight,
                  Colors.orange,
                  width,
                ),
                _buildInfoCard(
                  'BMI',
                  widget.patient.bmi?.toStringAsFixed(1) ?? 'N/A',
                  Icons.calculate,
                  Colors.indigo,
                  width,
                ),
              ];

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: cards
                    .animate(interval: 100.ms)
                    .fadeIn(duration: 400.ms)
                    .scale(begin: const Offset(0.9, 0.9)),
              );
            },
          ),
          const SizedBox(height: 32),
          _buildSectionHeader(
              'Contact Information', Icons.contact_phone_outlined),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
            ),
            child: Column(
              children: [
                _buildContactTile(
                    Icons.phone, 'Phone Number', widget.patient.contactNumber),
                _buildDivider(),
                _buildContactTile(Icons.location_on, 'Nationality',
                    widget.patient.nationality),
                _buildDivider(),
                _buildContactTile(
                    Icons.work, 'Occupation', widget.patient.occupation),
                _buildDivider(),
                _buildContactTile(Icons.people, 'Marital Status',
                    widget.patient.maritalStatus),
              ],
            ),
          ).animate().fadeIn().slideY(begin: 0.1, duration: 500.ms),
          const SizedBox(height: 32),
          _buildSectionHeader(
              'Emergency Contact', Icons.emergency_share_outlined),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
            ),
            child: Column(
              children: [
                _buildContactTile(
                    Icons.person, 'Name', widget.patient.emergencyContactName),
                _buildDivider(),
                _buildContactTile(
                    Icons.phone, 'Phone', widget.patient.emergencyContactPhone),
                _buildDivider(),
                _buildContactTile(Icons.link, 'Relationship',
                    widget.patient.emergencyContactRelationship),
              ],
            ),
          ).animate().fadeIn().slideY(begin: 0.1, duration: 500.ms),
          const SizedBox(height: 32),
          _buildSectionHeader('Medical History', Icons.history_edu_outlined),
          const SizedBox(height: 16),
          _buildInfoBlock('Family Medical History',
              widget.patient.familyMedicalHistory ?? 'None recorded'),
          if (widget.patient.hasSurgicalHistory) ...[
            const SizedBox(height: 16),
            _buildInfoBlock('Surgical History',
                widget.patient.surgeryDetails ?? 'Details not provided'),
          ],
          if (widget.patient.isTakingMedication) ...[
            const SizedBox(height: 16),
            _buildInfoBlock('Current Medications',
                widget.patient.currentMedications ?? 'None recorded'),
          ],
          const SizedBox(height: 32),
          _buildSectionHeader('Lifestyle', Icons.self_improvement_outlined),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildLifestyleChip(
                  'Smoking', widget.patient.smokingStatus, Icons.smoking_rooms),
              _buildLifestyleChip('Alcohol', widget.patient.alcoholConsumption,
                  Icons.local_drink),
              _buildLifestyleChip('Activity',
                  widget.patient.physicalActivityLevel, Icons.directions_run),
              if (widget.patient.sleepHoursPerNight != null)
                _buildLifestyleChip('Sleep',
                    '${widget.patient.sleepHoursPerNight} hrs', Icons.bedtime),
            ],
          ).animate().fadeIn().slideX(begin: 0.1, duration: 600.ms),
          if (widget.patient.drugAllergyDetails != null &&
              widget.patient.drugAllergyDetails!.isNotEmpty) ...[
            const SizedBox(height: 32),
            _buildSectionHeader('Allergies & Notes', Icons.note_alt_outlined),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.red.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red.shade100),
                    ),
                    child: Icon(Icons.warning_amber_rounded,
                        color: Colors.red.shade700),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Drug Allergies',
                            style: GoogleFonts.poppins(
                                color: Colors.red.shade900,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        const SizedBox(height: 8),
                        Text(widget.patient.drugAllergyDetails!,
                            style: TextStyle(
                                color: Colors.red.shade900,
                                height: 1.5,
                                fontSize: 15)),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn().shake(duration: 500.ms),
          ],
          const SizedBox(height: 60), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, indent: 64, color: Colors.grey.withOpacity(0.1));
  }

  Widget _buildContactTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppTheme.primaryGreen, size: 20),
      ),
      title: Text(title,
          style: GoogleFonts.poppins(fontSize: 13, color: AppTheme.textGrey)),
      subtitle: Text(subtitle,
          style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppTheme.textDark)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    );
  }

  Widget _buildVisitsTab(bool isDesktop) {
    final visitState = ref.watch(visitNotifierProvider);

    if (visitState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (visitState.failureOrSuccessOption.isSome()) {
      return visitState.failureOrSuccessOption.fold(
        () => const SizedBox.shrink(),
        (failure) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading visits: ${failure.message}',
                  style: GoogleFonts.poppins(color: Colors.red)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(visitNotifierProvider.notifier)
                      .getVisits(widget.patient.id);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (visitState.visits.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.history_edu,
                  size: 64, color: AppTheme.primaryGreen.withOpacity(0.5)),
            ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 24),
            Text('No visits recorded yet',
                style: GoogleFonts.poppins(
                    color: AppTheme.textDark,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Start by adding a new visit using the button below.',
                style: GoogleFonts.poppins(color: AppTheme.textGrey)),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditVisitScreen(
                      patientId: widget.patient.id,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add First Visit'),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ).animate().fadeIn(duration: 400.ms),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(isDesktop ? 32 : 24),
      itemCount: visitState.visits.length,
      itemBuilder: (context, index) {
        final visit = visitState.visits[index];
        return _buildVisitTimelineItem(visit)
            .animate(delay: (100 * index).ms)
            .fadeIn()
            .slideX(begin: 0.1);
      },
    );
  }

  Widget _buildVisitTimelineItem(visit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryGreen.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryGreen,
                          AppTheme.primaryGreen.withOpacity(0.1)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditVisitScreen(
                        patientId: widget.patient.id,
                        existingVisit: visit,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              // Simple date formatting
                              visit.date.toLocal().toString().split(' ')[0],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppTheme.primaryGreen,
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios,
                              size: 16, color: AppTheme.textGrey),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        visit.diagnosis,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 12),
                      Text(
                        'ASSESSMENT',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textGrey,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        visit.assessment,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: AppTheme.textDark,
                          height: 1.6,
                        ),
                      ),
                      if (visit.reports.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: visit.reports.map<Widget>((report) {
                            return InkWell(
                              onTap: () => _launchUrl(report.fileUrl),
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppTheme.backgroundLight,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.2)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.attach_file,
                                        size: 16, color: AppTheme.textGrey),
                                    const SizedBox(width: 8),
                                    Text(
                                      report.name,
                                      style: TextStyle(
                                          fontSize: 13,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.primaryGreen),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FilledButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VisitChatScreen(
                                    patientId: widget.patient.id,
                                    visit: visit,
                                    patient: widget.patient,
                                  ),
                                ),
                              );
                            },
                            icon:
                                const Icon(Icons.chat_bubble_outline, size: 18),
                            label: const Text('AI Assistant'),
                            style: FilledButton.styleFrom(
                              backgroundColor:
                                  AppTheme.primaryGreen.withOpacity(0.1),
                              foregroundColor: AppTheme.primaryGreen,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryGreen, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildAlertChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.red.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.red, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBlock(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(),
              style: GoogleFonts.poppins(
                  color: AppTheme.textGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5)),
          const SizedBox(height: 10),
          Text(content,
              style: GoogleFonts.poppins(
                  color: AppTheme.textDark, fontSize: 16, height: 1.5)),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1, duration: 400.ms);
  }

  Widget _buildLifestyleChip(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppTheme.primaryGreen, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style:
                      const TextStyle(fontSize: 10, color: AppTheme.textGrey)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark)),
            ],
          ),
        ],
      ),
    );
  }

// Existing _buildInfoCard method...
  Widget _buildInfoCard(
      String label, String value, IconData icon, Color color, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(value,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppTheme.textDark)),
          const SizedBox(height: 4),
          Text(label,
              style:
                  GoogleFonts.poppins(color: AppTheme.textGrey, fontSize: 14)),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
