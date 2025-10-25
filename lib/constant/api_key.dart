import 'package:flutter_dotenv/flutter_dotenv.dart';

String get geminiApiKey {
  final key = dotenv.env['GEMINI_API_KEY'];
  if (key == null || key.isEmpty) {
    throw StateError(
      'GEMINI_API_KEY is not set. Please provide it in your .env file.',
    );
  }
  return key;
}
