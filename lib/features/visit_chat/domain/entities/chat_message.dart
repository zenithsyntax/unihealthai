class ChatAttachment {
  final String? url;
  final String? name;
  final String? mimeType;

  ChatAttachment({this.url, this.name, this.mimeType});

  factory ChatAttachment.fromMap(Map<String, dynamic> map) {
    return ChatAttachment(
      url: map['url'] as String?,
      name: map['name'] as String?,
      mimeType: map['mimeType'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'name': name,
      'mimeType': mimeType,
    };
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final List<ChatAttachment> attachments;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.attachments = const [],
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    var attachments = <ChatAttachment>[];

    // Handle new format
    if (map['attachments'] != null) {
      final list = map['attachments'] as List;
      attachments = list
          .map((e) => ChatAttachment.fromMap(e as Map<String, dynamic>))
          .toList();
    }
    // Handle old format (backward compatibility)
    else if (map['attachmentUrl'] != null) {
      attachments.add(ChatAttachment(
        url: map['attachmentUrl'] as String?,
        name: map['attachmentName'] as String?,
      ));
    }

    return ChatMessage(
      text: map['text'] as String? ?? '',
      isUser: map['isUser'] as bool? ?? false,
      attachments: attachments,
    );
  }
}
