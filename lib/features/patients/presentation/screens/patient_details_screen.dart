import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unihealthai/features/patients/application/visit_notifier.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/patient_entity.dart';
import '../../../chat/presentation/widgets/ai_chat_widget.dart';
import 'add_edit_visit_screen.dart';

class PatientDetailsScreen extends ConsumerStatefulWidget {
  final PatientEntity patient;

  const PatientDetailsScreen({super.key, required this.patient});

  @override
  ConsumerState<PatientDetailsScreen> createState() =>
      _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends ConsumerState<PatientDetailsScreen> {
  bool _isChatOpen = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(visitNotifierProvider.notifier).getVisits(widget.patient.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final visitState = ref.watch(visitNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patient.name),
        actions: [
          IconButton(
            icon: Icon(
                _isChatOpen ? Icons.chat_bubble : Icons.chat_bubble_outline),
            onPressed: () {
              setState(() {
                _isChatOpen = !_isChatOpen;
              });
            },
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPatientInfoCard(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Visits History',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon:
                              const Icon(Icons.add_circle, color: Colors.blue),
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (visitState.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (visitState.visits.isEmpty)
                      const Text('No visits recorded.')
                    else
                      ...visitState.visits
                          .map((visit) => _buildVisitCard(visit)),
                  ],
                ),
              ),
            ),
          ),
          if (_isChatOpen)
            Expanded(
              flex: 1,
              child: AIChatWidget(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPatientInfoCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${widget.patient.name}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Age: ${widget.patient.age}'),
            Text('Gender: ${widget.patient.gender}'),
            Text('Contact: ${widget.patient.contactNumber}'),
          ],
        ),
      ),
    );
  }

  Widget _buildVisitCard(VisitEntity visit) {
    return GestureDetector(
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
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date: ${visit.date.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Icon(Icons.edit, size: 16, color: Colors.grey),
                ],
              ),
              const Divider(),
              Text('Assessment: ${visit.assessment}'),
              Text('Diagnosis: ${visit.diagnosis}'),
              Text('Prescription: ${visit.prescription}'),
              if (visit.notes != null && visit.notes!.isNotEmpty)
                Text('Notes: ${visit.notes}'),
              const SizedBox(height: 10),
              if (visit.reports.isNotEmpty) ...[
                const Text('Medical Reports:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 8,
                  children: visit.reports
                      .map((report) => ActionChip(
                            label: Text(report.name),
                            avatar: const Icon(Icons.file_present),
                            onPressed: () {
                              _launchUrl(report.fileUrl);
                            },
                          ))
                      .toList(),
                )
              ]
            ],
          ),
        ),
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
