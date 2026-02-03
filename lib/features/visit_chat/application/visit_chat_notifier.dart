import 'dart:async';

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
  VisitEntity? visit
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
        _initializeContext(_params.visit!, _params.patientId, _params.visitId);
      } else {
        state = state.copyWith(messages: messages);
      }
    });

    ref.onDispose(() {
      subscription.cancel();
    });

    return VisitChatState(isLoading: true);
  }

  Future<void> _initializeContext(
      VisitEntity visit, String patientId, String visitId) async {
    // Create context message
    final contextMessage = '''
Here is the context for this visit:
Date: ${visit.date.toString()}
Diagnosis: ${visit.diagnosis}
Assessment: ${visit.assessment}
Prescription: ${visit.prescription}
Notes: ${visit.notes ?? 'None'}
''';
    // Save as AI message (or system message, treating as non-user)
    await _repository.saveMessage(
        patientId: patientId,
        visitId: visitId,
        text: contextMessage,
        isUser: false);
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    // 1. Save User Message
    await _repository.saveMessage(
        patientId: _params.patientId,
        visitId: _params.visitId,
        text: text,
        isUser: true);

    state = state.copyWith(isLoading: true);

    // 2. Call AI
    final response = await _repository.generateAIResponse(text);

    // 3. Save AI Response
    if (response != null) {
      await _repository.saveMessage(
          patientId: _params.patientId,
          visitId: _params.visitId,
          text: response,
          isUser: false);
    }

    state = state.copyWith(isLoading: false);
  }
}

final visitChatNotifierProvider =
    NotifierProvider<VisitChatNotifier, VisitChatState>(() {
  return VisitChatNotifier();
});
