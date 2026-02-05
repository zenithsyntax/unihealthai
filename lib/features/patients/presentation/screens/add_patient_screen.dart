import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../application/patient_notifier.dart';
import '../../domain/entities/patient_entity.dart';

class AddPatientScreen extends ConsumerStatefulWidget {
  final PatientEntity? patientToEdit;

  const AddPatientScreen({super.key, this.patientToEdit});

  @override
  ConsumerState<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends ConsumerState<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();

  // 🧍 Personal / Demographics
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  DateTime _dateOfBirth = DateTime.now();
  String _selectedGender = 'Male';
  final _nationalityController = TextEditingController();
  String _maritalStatus = 'Single';
  final _occupationController = TextEditingController();

  // 📞 Contact / Emergency
  final _contactController = TextEditingController();
  final _emergencyNameController = TextEditingController();
  final _emergencyPhoneController = TextEditingController();
  final _emergencyRelationController = TextEditingController();

  // 🏥 Medical History
  String _bloodType = 'O+';
  bool _hasHeartCondition = false;
  bool _hasDiabetes = false;
  bool _hasAsthma = false;
  bool _hasHighBloodPressure = false;
  bool _hasSurgicalHistory = false;
  final _surgeryDetailsController = TextEditingController();
  final _familyHistoryController = TextEditingController();

  // 💊 Medications & Allergies
  bool _isTakingMedication = false;
  final _currentMedicationsController = TextEditingController();
  final _drugAllergiesController = TextEditingController();
  final _foodAllergiesController = TextEditingController();

  // 🧠 Mental & Lifestyle
  final _mentalHealthNotesController = TextEditingController();
  String _smokingStatus = 'Never';
  String _alcoholConsumption = 'None';
  String _physicalActivityLevel = 'Sedentary';
  final _sleepHoursController = TextEditingController();

  // 📏 Body Metrics / Vitals
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _restingHeartRateController = TextEditingController();
  final _bloodPressureController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.patientToEdit != null) {
      final p = widget.patientToEdit!;
      _firstNameController.text = p.firstName;
      _lastNameController.text = p.lastName;
      _selectedGender = p.gender;
      _dateOfBirth = p.dateOfBirth;
      _nationalityController.text = p.nationality;
      _maritalStatus = p.maritalStatus;
      _occupationController.text = p.occupation;
      _contactController.text = p.contactNumber;
      _emergencyNameController.text = p.emergencyContactName;
      _emergencyPhoneController.text = p.emergencyContactPhone;
      _emergencyRelationController.text = p.emergencyContactRelationship;
      _bloodType = p.bloodType;
      _hasHeartCondition = p.hasHeartCondition;
      _hasDiabetes = p.hasDiabetes;
      _hasAsthma = p.hasAsthma;
      _hasHighBloodPressure = p.hasHighBloodPressure;
      _hasSurgicalHistory = p.hasSurgicalHistory;
      _surgeryDetailsController.text = p.surgeryDetails ?? '';
      _familyHistoryController.text = p.familyMedicalHistory ?? '';
      _isTakingMedication = p.isTakingMedication;
      _currentMedicationsController.text = p.currentMedications ?? '';
      _drugAllergiesController.text = p.drugAllergyDetails ?? '';
      _foodAllergiesController.text = p.foodAllergyDetails ?? '';
      _mentalHealthNotesController.text = p.mentalHealthNotes ?? '';
      _smokingStatus = p.smokingStatus;
      _alcoholConsumption = p.alcoholConsumption;
      _physicalActivityLevel = p.physicalActivityLevel;
      _sleepHoursController.text = p.sleepHoursPerNight?.toString() ?? '';
      _heightController.text = p.height > 0 ? p.height.toString() : '';
      _weightController.text = p.weight > 0 ? p.weight.toString() : '';
      _restingHeartRateController.text = p.restingHeartRate?.toString() ?? '';
      _bloodPressureController.text = p.bloodPressure ?? '';
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _nationalityController.dispose();
    _occupationController.dispose();
    _contactController.dispose();
    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();
    _emergencyRelationController.dispose();
    _surgeryDetailsController.dispose();
    _familyHistoryController.dispose();
    _currentMedicationsController.dispose();
    _drugAllergiesController.dispose();
    _foodAllergiesController.dispose();
    _mentalHealthNotesController.dispose();
    _sleepHoursController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _restingHeartRateController.dispose();
    _bloodPressureController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  Future<void> _savePatient() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final currentUser = ref.read(firebaseAuthProvider).currentUser;
        if (currentUser == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error: No logged in doctor found')),
          );
          return;
        }

        final double height = double.tryParse(_heightController.text) ?? 0.0;
        final double weight = double.tryParse(_weightController.text) ?? 0.0;
        double? bmi;
        if (height > 0 && weight > 0) {
          final heightM = height / 100;
          bmi = weight / (heightM * heightM);
        }

        final newPatient = PatientEntity(
          id: widget.patientToEdit?.id ?? '',
          doctorId: currentUser.uid,
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          gender: _selectedGender,
          dateOfBirth: _dateOfBirth,
          nationality: _nationalityController.text.trim(),
          maritalStatus: _maritalStatus,
          occupation: _occupationController.text.trim(),
          contactNumber: _contactController.text.trim(),
          emergencyContactName: _emergencyNameController.text.trim(),
          emergencyContactPhone: _emergencyPhoneController.text.trim(),
          emergencyContactRelationship:
              _emergencyRelationController.text.trim(),
          bloodType: _bloodType,
          hasHeartCondition: _hasHeartCondition,
          hasDiabetes: _hasDiabetes,
          hasAsthma: _hasAsthma,
          hasHighBloodPressure: _hasHighBloodPressure,
          hasSurgicalHistory: _hasSurgicalHistory,
          surgeryDetails: _surgeryDetailsController.text.trim(),
          familyMedicalHistory: _familyHistoryController.text.trim(),
          isTakingMedication: _isTakingMedication,
          currentMedications: _currentMedicationsController.text.trim(),
          drugAllergyDetails: _drugAllergiesController.text.trim(),
          foodAllergyDetails: _foodAllergiesController.text.trim(),
          mentalHealthNotes: _mentalHealthNotesController.text.trim(),
          smokingStatus: _smokingStatus,
          alcoholConsumption: _alcoholConsumption,
          physicalActivityLevel: _physicalActivityLevel,
          sleepHoursPerNight: int.tryParse(_sleepHoursController.text.trim()),
          height: height,
          weight: weight,
          bmi: bmi,
          restingHeartRate:
              int.tryParse(_restingHeartRateController.text.trim()),
          bloodPressure: _bloodPressureController.text.trim(),
          insuranceProvider: widget.patientToEdit?.insuranceProvider,
          insurancePolicyNumber: widget.patientToEdit?.insurancePolicyNumber,
          consentToTreatment: widget.patientToEdit?.consentToTreatment ?? false,
          consentDate: widget.patientToEdit?.consentDate,
          notes: widget.patientToEdit?.notes,
          createdAt: widget.patientToEdit?.createdAt ?? DateTime.now(),
          updatedAt: DateTime.now(),
          visits: widget.patientToEdit?.visits ?? [],
        );

        if (widget.patientToEdit != null) {
          await ref
              .read(patientNotifierProvider.notifier)
              .updatePatient(newPatient);
        } else {
          await ref
              .read(patientNotifierProvider.notifier)
              .addPatient(newPatient);
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(widget.patientToEdit != null
                  ? 'Patient profile updated successfully!'
                  : 'Patient added successfully!'),
              backgroundColor: Colors.green.shade700,
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Error ${widget.patientToEdit != null ? 'updating' : 'adding'} patient: $e'),
              backgroundColor: Colors.red.shade700,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(widget.patientToEdit != null
            ? 'Edit Patient Profile'
            : 'New Patient Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black87,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          children: [
            _buildSectionCard(
              title: 'Demographics',
              icon: Icons.person_rounded,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstNameController,
                        decoration: _inputDecoration('First Name',
                            icon: Icons.badge_outlined),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _lastNameController,
                        decoration: _inputDecoration('Last Name',
                            icon: Icons.badge_outlined),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedGender,
                        decoration: _inputDecoration('Gender',
                            icon: Icons.male_outlined),
                        borderRadius: BorderRadius.circular(12),
                        items: ['Male', 'Female', 'Other']
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) => setState(() => _selectedGender = v!),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(context),
                        borderRadius: BorderRadius.circular(12),
                        child: InputDecorator(
                          decoration: _inputDecoration('Date of Birth',
                              icon: Icons.calendar_today_outlined),
                          child: Text(
                            "${_dateOfBirth.toLocal()}".split(' ')[0],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nationalityController,
                  decoration: _inputDecoration('Nationality',
                      icon: Icons.flag_outlined),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _maritalStatus,
                        decoration: _inputDecoration('Marital Status',
                            icon: Icons.family_restroom_outlined),
                        borderRadius: BorderRadius.circular(12),
                        items: ['Single', 'Married', 'Divorced', 'Widowed']
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) => setState(() => _maritalStatus = v!),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _occupationController,
                        decoration: _inputDecoration('Occupation',
                            icon: Icons.work_outline),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            _buildSectionCard(
              title: 'Contact & Emergency',
              icon: Icons.phone_in_talk_rounded,
              children: [
                TextFormField(
                  controller: _contactController,
                  decoration: _inputDecoration('Phone Number',
                      icon: Icons.phone_outlined),
                  keyboardType: TextInputType.phone,
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                const Text('Emergency Contact',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.grey)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emergencyNameController,
                  decoration: _inputDecoration('Contact Name',
                      icon: Icons.person_outline),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _emergencyPhoneController,
                        decoration: _inputDecoration('Contact Phone',
                            icon: Icons.phone_android_outlined),
                        keyboardType: TextInputType.phone,
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _emergencyRelationController,
                        decoration: _inputDecoration('Relationship',
                            icon: Icons.supervised_user_circle_outlined),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            _buildSectionCard(
              title: 'Medical History',
              icon: Icons.medical_services_rounded,
              children: [
                DropdownButtonFormField<String>(
                  value: _bloodType,
                  decoration: _inputDecoration('Blood Type',
                      icon: Icons.bloodtype_outlined),
                  borderRadius: BorderRadius.circular(12),
                  items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => _bloodType = v!),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildSwitchChip('Heart Condition', _hasHeartCondition,
                        (v) => setState(() => _hasHeartCondition = v)),
                    _buildSwitchChip('Diabetes', _hasDiabetes,
                        (v) => setState(() => _hasDiabetes = v)),
                    _buildSwitchChip('Asthma', _hasAsthma,
                        (v) => setState(() => _hasAsthma = v)),
                    _buildSwitchChip('High BP', _hasHighBloodPressure,
                        (v) => setState(() => _hasHighBloodPressure = v)),
                    _buildSwitchChip('Surgical Hx', _hasSurgicalHistory,
                        (v) => setState(() => _hasSurgicalHistory = v)),
                  ],
                ),
                if (_hasSurgicalHistory) ...[
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _surgeryDetailsController,
                    decoration: _inputDecoration('Surgery Details',
                        icon: Icons.healing_outlined),
                    maxLines: 2,
                  ),
                ],
                const SizedBox(height: 16),
                TextFormField(
                  controller: _familyHistoryController,
                  decoration: _inputDecoration('Family Medical History',
                      icon: Icons.history_outlined),
                  maxLines: 2,
                ),
              ],
            ),
            _buildSectionCard(
              title: 'Medications & Allergies',
              icon: Icons.medication_rounded,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Currently Taking Medication',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  value: _isTakingMedication,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (v) => setState(() => _isTakingMedication = v),
                ),
                if (_isTakingMedication)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                    child: TextFormField(
                      controller: _currentMedicationsController,
                      decoration: _inputDecoration('List Medications',
                          icon: Icons.list_alt_outlined),
                      maxLines: 2,
                    ),
                  ),
                TextFormField(
                  controller: _drugAllergiesController,
                  decoration: _inputDecoration('Drug Allergies',
                      icon: Icons.warning_amber_rounded),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _foodAllergiesController,
                  decoration: _inputDecoration('Food Allergies',
                      icon: Icons.restaurant_outlined),
                ),
              ],
            ),
            _buildSectionCard(
              title: 'Lifestyle & Mental Health',
              icon: Icons.psychology_rounded,
              children: [
                TextFormField(
                  controller: _mentalHealthNotesController,
                  decoration: _inputDecoration('Mental Health Notes',
                      icon: Icons.create_outlined),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _smokingStatus,
                        decoration: _inputDecoration('Smoking',
                            icon: Icons.smoking_rooms_outlined),
                        items: ['Never', 'Former', 'Current']
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) => setState(() => _smokingStatus = v!),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _alcoholConsumption,
                        decoration: _inputDecoration('Alcohol',
                            icon: Icons.local_drink_outlined),
                        items: ['None', 'Occasional', 'Moderate', 'Heavy']
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _alcoholConsumption = v!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _physicalActivityLevel,
                  decoration: _inputDecoration('Physical Activity',
                      icon: Icons.directions_run_outlined),
                  items: [
                    'Sedentary',
                    'Light',
                    'Moderate',
                    'Active',
                    'Very Active'
                  ]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => _physicalActivityLevel = v!),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _sleepHoursController,
                  decoration: _inputDecoration('Sleep Hours / Night',
                      icon: Icons.bedtime_outlined),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            _buildSectionCard(
              title: 'Body Metrics',
              icon: Icons.accessibility_new_rounded,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _heightController,
                        decoration: _inputDecoration('Height (cm)',
                            icon: Icons.height_outlined),
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Required';
                          if (double.tryParse(v) == null) return 'Invalid';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _weightController,
                        decoration: _inputDecoration('Weight (kg)',
                            icon: Icons.monitor_weight_outlined),
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Required';
                          if (double.tryParse(v) == null) return 'Invalid';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _restingHeartRateController,
                        decoration: _inputDecoration('Heart Rate (bpm)',
                            icon: Icons.favorite_border_outlined),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _bloodPressureController,
                        decoration: _inputDecoration('BP (e.g. 120/80)',
                            icon: Icons.compress_outlined),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      side: BorderSide(color: Colors.grey.shade400),
                    ),
                    child: const Text('Cancel',
                        style: TextStyle(fontSize: 16, color: Colors.black54)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _savePatient,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : Text(
                            widget.patientToEdit != null
                                ? 'Update Patient Profile'
                                : 'Save Patient Profile',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(
      {required String title,
      required IconData icon,
      required List<Widget> children}) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon,
                      color: Theme.of(context).primaryColor, size: 28),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 20,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchChip(
      String label, bool value, ValueChanged<bool> onChanged) {
    return FilterChip(
      label: Text(label),
      selected: value,
      onSelected: onChanged,
      checkmarkColor: Colors.white,
      selectedColor: Theme.of(context).primaryColor,
      labelStyle: TextStyle(
        color: value ? Colors.white : Colors.black87,
        fontWeight: value ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), side: BorderSide.none),
    );
  }

  InputDecoration _inputDecoration(String label,
      {IconData? icon, String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon != null
          ? Icon(icon, size: 22, color: Colors.grey.shade600)
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      ),
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      labelStyle: TextStyle(color: Colors.grey.shade700),
    );
  }
}
