import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../domain/entities/chat_message.dart';

class VisitChatRepository {
  final FirebaseFirestore _firestore;

  VisitChatRepository(this._firestore);

  // Stream of messages for real-time updates
  Stream<List<Map<String, dynamic>>> getChatStream(
      String patientId, String visitId) {
    return _firestore
        .collection('patients')
        .doc(patientId)
        .collection('visits')
        .doc(visitId)
        .collection('chat')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> saveMessage({
    required String patientId,
    required String visitId,
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
        .collection('visits')
        .doc(visitId)
        .collection('chat')
        .add(data);
    print('Message saved to Firestore'); // Debug log
  }

  Future<String?> generateAIResponse(
    String message, {
    List<Map<String, dynamic>>? history,
    List<dynamic>? reports,
    // Optional local attachment
    List<({Uint8List bytes, String mimeType, String name})>? attachments,
  }) async {
    try {
      // Using gemini-2.0-flash as 1.5 is retired
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

      // 2. Add Medical Reports (Download and attach)
      if (reports != null && reports.isNotEmpty) {
        for (var report in reports) {
          try {
            final url = report.fileUrl as String;
            final name = report.name as String;

            String mimeType = 'application/octet-stream';
            if (url.contains('.pdf')) {
              mimeType = 'application/pdf';
            } else if (url.contains('.jpg') || url.contains('.jpeg')) {
              mimeType = 'image/jpeg';
            } else if (url.contains('.png')) {
              mimeType = 'image/png';
            }

            final response = await http.get(Uri.parse(url));
            if (response.statusCode == 200) {
              // Try InlineDataPart for FirebaseAI / VertexAI
              // Note: If InlineDataPart is not found, we might need DataPart or BlobPart
              // But standard firebase_vertexai uses InlineDataPart
              parts.add(InlineDataPart(mimeType, response.bodyBytes));
              parts.add(TextPart('Attached File: $name'));
            } else {
              parts.add(TextPart('Failed to download report: $name'));
            }
          } catch (e) {
            print('Error downloading report: $e');
            parts.add(TextPart('Error reading report: ${report.name}'));
          }
        }
      }

      // 3. Add Local Attachments
      if (attachments != null) {
        for (final file in attachments) {
          parts.add(InlineDataPart(file.mimeType, file.bytes));
          parts.add(TextPart('Attached File: ${file.name}'));
        }
      }

      // 4. Add Current Message
      parts.add(TextPart(message));

      final content = [Content.multi(parts)];
      final response = await model.generateContent(content);
      return response.text;
    } catch (e) {
      return "Error generating response: $e";
    }
  }
}

final visitChatRepositoryProvider = Provider<VisitChatRepository>((ref) {
  return VisitChatRepository(FirebaseFirestore.instance);
});
