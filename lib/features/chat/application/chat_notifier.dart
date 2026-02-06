import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../infrastructure/repositories/chat_repository.dart';

// Reusing ChatMessage from visit_chat to avoid duplication/conflicts if they are same structure
// or we can import the new one we just used in repository.
import 'dart:typed_data';
import '../../visit_chat/domain/entities/chat_message.dart';
import '../../patients/domain/entities/patient_entity.dart';

typedef ChatParams = ({
  String patientId,
  PatientEntity patient,
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

  String _buildContextString(PatientEntity patient) {
    return '''
[Patient Summary]
Name: ${patient.name}
Details: ${patient.age}y ${patient.gender}, ${patient.bloodType}
Critical: ${patient.hasDiabetes ? 'Diabetes' : ''} ${patient.hasHeartCondition ? 'Heart Condition' : ''} ${patient.drugAllergyDetails != null ? 'Allergies: ${patient.drugAllergyDetails}' : ''}
''';
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
      String prompt = '''
${_buildContextString(_params.patient)}

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
