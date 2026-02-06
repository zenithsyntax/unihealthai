import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../infrastructure/repositories/chat_repository.dart';

// Reusing ChatMessage from visit_chat to avoid duplication/conflicts if they are same structure
// or we can import the new one we just used in repository.
import 'dart:typed_data';
import '../../visit_chat/domain/entities/chat_message.dart';
import '../../patients/domain/entities/patient_entity.dart';

typedef ChatParams = ({
  String patientId,
  PatientEntity? patient, // Made nullable
});

final chatParamsProvider = Provider<ChatParams>((ref) {
  throw UnimplementedError('chatParamsProvider must be overridden');
});

class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;

  ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ChatNotifier extends Notifier<ChatState> {
  late final ChatRepository _repository;
  late final ChatParams _params;

  @override
  ChatState build() {
    _repository = ref.read(chatRepositoryProvider);
    _params = ref.read(chatParamsProvider);

    // Subscribe to stream
    final stream = _repository.getChatStream(_params.patientId);
    final subscription = stream.listen((data) {
      final messages = data.map((e) => ChatMessage.fromMap(e)).toList();
      state = state.copyWith(messages: messages, isLoading: false);
    });

    ref.onDispose(() {
      subscription.cancel();
    });

    return ChatState(isLoading: true);
  }

  String _buildContextString(PatientEntity? patient) {
    if (patient == null) {
      return '''
SYSTEM INSTRUCTION: You are an advanced medical AI assistant helping a doctor.
Your goal is to answer general medical questions or assist with administrative tasks.
Use professional medical terminology but be concise.
''';
    }

    print('Building context for patient: ${patient.name}');

    final StringBuffer buffer = StringBuffer();
    buffer.writeln(
        'SYSTEM INSTRUCTION: You are an advanced medical AI assistant helping a doctor.');
    buffer.writeln(
        'Your goal is to answer questions about the specific patient described below.');
    buffer.writeln('Use professional medical terminology but be concise.');
    buffer.writeln(
        'If the user asks about something not in the patient record, state that you do not have that information.');
    buffer.writeln('');
    buffer.writeln('[PATIENT PROFILE]');
    buffer.writeln('Name: ${patient.name}');
    buffer.writeln('ID: ${patient.id}');
    buffer.writeln('Age: ${patient.age} years');
    buffer.writeln('Gender: ${patient.gender}');
    buffer.writeln('Blood Type: ${patient.bloodType}');
    buffer.writeln('Contact: ${patient.contactNumber}');
    buffer.writeln('');
    buffer.writeln('[MEDICAL SUMMARY]');
    buffer.writeln('Conditions: ${[
      if (patient.hasDiabetes) 'Diabetes',
      if (patient.hasHeartCondition) 'Heart Condition',
      if (patient.hasAsthma) 'Asthma',
      if (patient.hasHighBloodPressure) 'High Blood Pressure'
    ].join(', ')}');
    buffer
        .writeln('Allergies: ${patient.drugAllergyDetails ?? "None recorded"}');
    buffer.writeln(
        'Current Meds: ${patient.currentMedications ?? "None recorded"}');
    buffer.writeln('Surgical Hx: ${patient.surgeryDetails ?? "None"}');
    buffer.writeln('Family Hx: ${patient.familyMedicalHistory ?? "None"}');
    buffer.writeln('');

    if (patient.visits.isNotEmpty) {
      buffer.writeln('[RECENT VISITS]');
      // Sort visits by date descending
      final sortedVisits = List.of(patient.visits)
        ..sort((a, b) => b.date.compareTo(a.date));

      // Take last 3 visits
      for (final visit in sortedVisits.take(3)) {
        buffer.writeln('- Date: ${visit.date.toString().split(' ')[0]}');
        buffer.writeln('  Diagnosis: ${visit.diagnosis}');
        buffer.writeln('  Assessment: ${visit.assessment}');
        buffer.writeln('  Prescription: ${visit.prescription}');
        buffer.writeln('');
      }
    }

    return buffer.toString();
  }

  Future<void> sendMessage(String text,
      {List<({Uint8List bytes, String mimeType, String name})>?
          attachments}) async {
    if (text.isEmpty && (attachments == null || attachments.isEmpty)) return;

    // 1. Save User Message
    await _repository.saveMessage(
      patientId: _params.patientId,
      text: text,
      isUser: true,
      attachments: attachments
              ?.map((e) =>
                  ChatAttachment(name: e.name, mimeType: e.mimeType, url: null))
              .toList() ??
          [],
    );

    state = state.copyWith(isLoading: true);

    try {
      // 2. Call AI
      final contextString = _buildContextString(_params.patient);
      String prompt = '''
$contextString

User Query: $text
''';

      // Keep recent history for context
      final history = state.messages.length > 5
          ? state.messages
              .sublist(state.messages.length - 5)
              .map((e) => {'text': e.text, 'isUser': e.isUser})
              .toList()
          : state.messages
              .map((e) => {'text': e.text, 'isUser': e.isUser})
              .toList();

      final response = await _repository.generateAIResponse(
        prompt,
        history: history,
        attachments: attachments,
      );

      // 3. Save AI Response
      if (response != null) {
        await _repository.saveMessage(
            patientId: _params.patientId, text: response, isUser: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final chatNotifierProvider = NotifierProvider<ChatNotifier, ChatState>(() {
  return ChatNotifier();
});
