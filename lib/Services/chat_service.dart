import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final List<Map<String, String>> messages = [];
  static const String openAiKey =
      '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';

  Future<String> sendMessage(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': messages,
        }),
      );

      if (response.statusCode == 200) {
        String content =
            jsonDecode(response.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });

        return content;
      } else {
        return 'An internal error occurred';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
