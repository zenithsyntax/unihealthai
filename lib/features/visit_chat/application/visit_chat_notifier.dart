import 'dart:async';
import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../features/patients/domain/entities/patient_entity.dart';
import '../domain/entities/chat_message.dart';
import '../infrastructure/repositories/visit_chat_repository.dart';

class VisitChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;

  VisitChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  VisitChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
  }) {
    return VisitChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

typedef VisitChatParams = ({
  String patientId,
  String visitId,
  VisitEntity? visit,
  PatientEntity? patient,
});

final visitChatParamsProvider = Provider<VisitChatParams>((ref) {
  throw UnimplementedError('visitChatParamsProvider must be overridden');
});

class VisitChatNotifier extends Notifier<VisitChatState> {
  late final VisitChatRepository _repository;
  late final VisitChatParams _params;

  @override
  VisitChatState build() {
    _repository = ref.read(visitChatRepositoryProvider);
    _params = ref.read(visitChatParamsProvider);

    // Listen to stream
    final stream =
        _repository.getChatStream(_params.patientId, _params.visitId);
    final subscription = stream.listen((data) {
      final messages = data.map((e) => ChatMessage.fromMap(e)).toList();

      if (messages.isEmpty && _params.visit != null) {
        // Auto-send initial context if chat is empty and we have visit details
        _initializeContext(_params.visit!, _params.patientId, _params.visitId,
            _params.patient);
      } else {
        state = state.copyWith(messages: messages);
      }
    });

    ref.onDispose(() {
      subscription.cancel();
    });

    return VisitChatState(isLoading: false);
  }

  String _buildContextString(VisitEntity visit, [PatientEntity? patient]) {
    final reportsList = visit.reports
        .map((r) => '- ${r.name} (Type: ${r.type}, Date: ${r.date})')
        .join('\n');

    String patientContext = '';
    if (patient != null) {
      patientContext = '''
[Patient Summary]
Name: ${patient.name}
Details: ${patient.age}y ${patient.gender}, ${patient.bloodType}
Critical: ${patient.hasDiabetes ? 'Diabetes' : ''} ${patient.hasHeartCondition ? 'Heart Condition' : ''} ${patient.drugAllergyDetails != null ? 'Allergies: ${patient.drugAllergyDetails}' : ''}
''';
    }

    return '''
Here is the context for this visit:

$patientContext

[Visit Details]
Date: ${visit.date.toString()}

[Diagnosis]
${visit.diagnosis}

[Assessment]
${visit.assessment}

[Prescription]
${visit.prescription}

[Manual Notes]
${visit.notes != null && visit.notes!.isNotEmpty ? visit.notes : 'None'}

[Attached Medical Reports]
${reportsList.isEmpty ? 'None' : reportsList}
''';
  }

  Future<void> _initializeContext(VisitEntity visit, String patientId,
      String visitId, PatientEntity? patient) async {
    // Create context message
    final contextMessage = _buildContextString(visit, patient);
    // Save as AI message (or system message, treating as non-user)
    await _repository.saveMessage(
        patientId: patientId,
        visitId: visitId,
        text: contextMessage,
        isUser: false);
  }

  Future<void> sendMessage(String text,
      {List<({Uint8List bytes, String mimeType, String name})>?
          attachments}) async {
    if (text.isEmpty) return;

    // 1. Save User Message
    await _repository.saveMessage(
      patientId: _params.patientId,
      visitId: _params.visitId,
      text: text,
      isUser: true,
      attachments: attachments
              ?.map((e) => ChatAttachment(
                  name: e.name, mimeType: e.mimeType, url: null)) // No URL yet
              .toList() ??
          [],
    );

    state = state.copyWith(isLoading: true);

    try {
      // 2. Call AI
      // Prepend context to the user's message so the AI knows what we are talking about
      String prompt = text;
      if (_params.visit != null) {
        prompt = '''
${_buildContextString(_params.visit!, _params.patient)}

User Query: $text
''';
      }

      // Get recent history (last 2 messages) to provide context
      final history = state.messages.length > 2
          ? state.messages
              .sublist(state.messages.length - 2)
              .map((e) => {'text': e.text, 'isUser': e.isUser})
              .toList()
          : state.messages
              .map((e) => {'text': e.text, 'isUser': e.isUser})
              .toList();

      final response = await _repository.generateAIResponse(
        prompt,
        history: history,
        reports: _params.visit?.reports,
        attachments: attachments,
      );

      // 3. Save AI Response
      if (response != null) {
        await _repository.saveMessage(
            patientId: _params.patientId,
            visitId: _params.visitId,
            text: response,
            isUser: false);
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final visitChatNotifierProvider =
    NotifierProvider<VisitChatNotifier, VisitChatState>(() {
  return VisitChatNotifier();
});
