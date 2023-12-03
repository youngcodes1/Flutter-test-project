import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Core/Apis/apis.dart';

class ChatService {
  messageResponse(String message) async {
    try {
      final response = await http.post(
        Uri.parse(apiRoute),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": message}
          ],
          'temperature': 0.7,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final completion = responseData['choices'][0]['message']["content"];
        return completion;
      } else {
        throw Exception('Failed to make request:${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
