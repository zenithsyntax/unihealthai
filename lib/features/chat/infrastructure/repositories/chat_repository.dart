import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../visit_chat/domain/entities/chat_message.dart';

class ChatRepository {
  final FirebaseFirestore _firestore;

  ChatRepository(this._firestore);

  // Stream of messages for real-time updates
  Stream<List<Map<String, dynamic>>> getChatStream(String patientId) {
    return _firestore
        .collection('patients')
        .doc(patientId)
        .collection('chat')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> saveMessage({
    required String patientId,
    required String text,
    required bool isUser,
    List<ChatAttachment> attachments = const [],
  }) async {
    final data = {
      'text': text,
      'isUser': isUser,
      'timestamp': FieldValue.serverTimestamp(),
    };

    if (attachments.isNotEmpty) {
      data['attachments'] = attachments.map((e) => e.toMap()).toList();
    }

    await _firestore
        .collection('patients')
        .doc(patientId)
        .collection('chat')
        .add(data);
  }

  Future<String?> generateAIResponse(
    String message, {
    List<Map<String, dynamic>>? history,
    List<({Uint8List bytes, String mimeType, String name})>? attachments,
  }) async {
    try {
      // Using 'gemini-2.0-flash' as requested and appropriate for 2026.
      final model =
          FirebaseAI.vertexAI().generativeModel(model: 'gemini-2.0-flash');

      final parts = <Part>[];

      // 1. Add History (Context)
      if (history != null && history.isNotEmpty) {
        final historyText = history.map((msg) {
          final role = msg['isUser'] == true ? 'User' : 'AI';
          return '$role: ${msg['text']}';
        }).join('\n');
        parts.add(TextPart('Previous Chat History:\n$historyText\n'));
      }

      // 2. Add Local Attachments
      if (attachments != null) {
        for (final file in attachments) {
          parts.add(InlineDataPart(file.mimeType, file.bytes));
          parts.add(TextPart('Attached File: ${file.name}'));
        }
      }

      // 3. Add Current Message
      parts.add(TextPart(message));

      // To generate text output, call generateContent with the text input
      final content = [Content.multi(parts)];
      final response = await model.generateContent(content);
      return response.text;
    } catch (e) {
      return "Error: $e";
    }
  }
}

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(FirebaseFirestore.instance);
});
