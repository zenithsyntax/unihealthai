import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatRepository {
  Future<String?> sendMessage(String message) async {
    try {
      // Initialize the Vertex AI Gemini API backend service
      // Using 'gemini-2.5-flash' as requested and appropriate for 2026.
      final model =
          FirebaseAI.vertexAI().generativeModel(model: 'gemini-2.5-flash');

      // Provide a prompt that contains text
      final prompt = [Content.text(message)];

      // To generate text output, call generateContent with the text input
      final response = await model.generateContent(prompt);
      return response.text;
    } catch (e) {
      return "Error: $e";
    }
  }
}

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository();
});
