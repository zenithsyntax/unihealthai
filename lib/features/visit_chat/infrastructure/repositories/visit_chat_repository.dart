import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  }) async {
    await _firestore
        .collection('patients')
        .doc(patientId)
        .collection('visits')
        .doc(visitId)
        .collection('chat')
        .add({
      'text': text,
      'isUser': isUser,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<String?> generateAIResponse(String message,
      {List<Map<String, dynamic>>? history}) async {
    try {
      final model =
          FirebaseAI.vertexAI().generativeModel(model: 'gemini-2.5-flash');

      // Convert history to Content objects if needed, for now just sending the new message or simple context
      // Robust implementation would convert the full history.
      // For this step, let's just send the text.
      // TODO: Improve context handling if expanding.

      final prompt = [Content.text(message)];
      final response = await model.generateContent(prompt);
      return response.text;
    } catch (e) {
      return "Error generating response: $e";
    }
  }
}

final visitChatRepositoryProvider = Provider<VisitChatRepository>((ref) {
  return VisitChatRepository(FirebaseFirestore.instance);
});
