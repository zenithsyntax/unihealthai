import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:io';

void main() async {
  final apiKey = 'AIzaSyC7fM5mAXFGIWKcghun1jd5dUEtT9ebV-8';
  final model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);

  print('Listing available models...');
  try {
    // Checking if the SDK has a way to list models directly or if we have to assume.
    // The 'google_generative_ai' package unfortunately does NOT export a `listModels` function easily in the high-level API
    // without digging into the internal client. Use a raw http request if needed?
    // Actually, let's try 'gemini-1.0-pro' since 'gemini-pro' failed.
    // And 'gemini-1.5-flash-8b' (latest small model).

    // Since I can't easily ListModels with the pure high-level Dart SDK (it wraps it),
    // I will brute-force test a wider range of potential model strings.

    final candidates = [
      'gemini-1.5-flash-8b',
      'gemini-1.5-flash-001',
      'gemini-1.5-flash-002',
      'gemini-1.5-pro-001',
      'gemini-1.5-pro-002',
      'gemini-1.0-pro',
      'gemini-1.0-pro-001'
    ];

    for (var m in candidates) {
      print('Testing: $m');
      try {
        final testModel = GenerativeModel(model: m, apiKey: apiKey);
        final response = await testModel.generateContent([Content.text('Hi')]);
        print('>>> SUCCESS: $m is AVAILABLE! <<<');
        exit(0);
      } catch (e) {
        if (e.toString().contains('Quota')) {
          print('EXISTS but Quota exceeded: $m');
        } else if (e.toString().contains('not found')) {
          print('Not found: $m');
        } else {
          print('Error ($m): $e');
        }
      }
    }
  } catch (e) {
    print('Error: $e');
  }
}
