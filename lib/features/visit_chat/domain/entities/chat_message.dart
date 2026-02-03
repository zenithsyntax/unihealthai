class ChatMessage {
  final String text;
  final bool isUser;
  // potentially timestamp or other metadata can be added here

  ChatMessage({required this.text, required this.isUser});

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      text: map['text'] as String? ?? '',
      isUser: map['isUser'] as bool? ?? false,
    );
  }
}
