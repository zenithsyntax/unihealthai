import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:unihealthai/features/patients/application/visit_notifier.dart';
import 'package:unihealthai/features/patients/domain/entities/patient_entity.dart';
import 'package:uuid/uuid.dart';

class AddEditVisitScreen extends ConsumerStatefulWidget {
  final String patientId;
  final VisitEntity? existingVisit;

  const AddEditVisitScreen(
      {super.key, required this.patientId, this.existingVisit});

  @override
  ConsumerState<AddEditVisitScreen> createState() => _AddEditVisitScreenState();
}

class _AddEditVisitScreenState extends ConsumerState<AddEditVisitScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _assessmentController;
  late TextEditingController _diagnosisController;
  late TextEditingController _prescriptionController;
  late TextEditingController _notesController;
  late DateTime _selectedDate;

  // List of reports. We mix existing (URLs) and new (Files -> to be uploaded).
  // Actually, easiest is to upload immediately when picked.
  // So we just maintain a list of MedicalReportEntity.
  List<MedicalReportEntity> _reports = [];
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    final visit = widget.existingVisit;
    _assessmentController =
        TextEditingController(text: visit?.assessment ?? '');
    _diagnosisController = TextEditingController(text: visit?.diagnosis ?? '');
    _prescriptionController =
        TextEditingController(text: visit?.prescription ?? '');
    _notesController = TextEditingController(text: visit?.notes ?? '');
    _selectedDate = visit?.date ?? DateTime.now();
    _reports = visit?.reports.toList() ?? [];
  }

  @override
  void dispose() {
    _assessmentController.dispose();
    _diagnosisController.dispose();
    _prescriptionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      Uint8List? fileBytes = result.files.single.bytes;
      final fileName = result.files.single.name;

      if (fileBytes == null && result.files.single.path != null) {
        fileBytes = await File(result.files.single.path!).readAsBytes();
      }

      if (fileBytes != null) {
        setState(() {
          _isUploading = true;
        });

        final visitId = widget.existingVisit?.id ?? const Uuid().v4();

        final notifier = ref.read(visitNotifierProvider.notifier);
        final uploadResult = await notifier.uploadReport(
            fileBytes, fileName, widget.patientId, visitId);

        uploadResult.fold(
          (error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Upload failed: $error')));
          },
          (url) {
            final report = MedicalReportEntity(
              id: const Uuid().v4(),
              name: fileName,
              fileUrl: url,
              date: DateTime.now(),
              type: result.files.single.extension ?? 'file',
            );
            setState(() {
              _reports.add(report);
            });
          },
        );

        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveVisit() {
    if (_formKey.currentState!.validate()) {
      final visitId = widget.existingVisit?.id ?? const Uuid().v4();
      final visit = VisitEntity(
        id: visitId,
        date: _selectedDate,
        assessment: _assessmentController.text,
        diagnosis: _diagnosisController.text,
        prescription: _prescriptionController.text,
        notes: _notesController.text,
        reports: _reports,
      );

      final notifier = ref.read(visitNotifierProvider.notifier);
      if (widget.existingVisit != null) {
        notifier.updateVisit(widget.patientId, visit);
      } else {
        notifier.addVisit(widget.patientId, visit);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingVisit != null ? 'Edit Visit' : 'Add Visit'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: Text(
                    'Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _assessmentController,
                decoration: const InputDecoration(
                    labelText: 'Assessment', border: OutlineInputBorder()),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter assessment' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _diagnosisController,
                decoration: const InputDecoration(
                    labelText: 'Diagnosis', border: OutlineInputBorder()),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter diagnosis' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _prescriptionController,
                decoration: const InputDecoration(
                    labelText: 'Prescription', border: OutlineInputBorder()),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter prescription' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                    labelText: 'Notes', border: OutlineInputBorder()),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Medical Reports',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.upload_file),
                    onPressed: _isUploading ? null : _pickAndUploadFile,
                  ),
                ],
              ),
              if (_isUploading) const LinearProgressIndicator(),
              const SizedBox(height: 10),
              ..._reports.map((report) => ListTile(
                    leading: const Icon(Icons.attach_file),
                    title: Text(report.name),
                    subtitle:
                        Text(DateFormat('yyyy-MM-dd').format(report.date)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _reports.remove(report);
                        });
                      },
                    ),
                  )),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isUploading ? null : _saveVisit,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16)),
                child: Text(widget.existingVisit != null
                    ? 'Update Visit'
                    : 'Save Visit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
