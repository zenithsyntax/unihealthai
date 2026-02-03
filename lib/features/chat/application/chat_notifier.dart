import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../infrastructure/repositories/chat_repository.dart';

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

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
  @override
  ChatState build() {
    return ChatState();
  }

  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;

    state = state.copyWith(
      messages: [...state.messages, ChatMessage(text: message, isUser: true)],
      isLoading: true,
      error: null,
    );

    try {
      final repository = ref.read(chatRepositoryProvider);
      final response = await repository.sendMessage(message);
      state = state.copyWith(
        messages: [
          ...state.messages,
          ChatMessage(text: response ?? "No response", isUser: false)
        ],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final chatNotifierProvider = NotifierProvider<ChatNotifier, ChatState>(() {
  return ChatNotifier();
});
