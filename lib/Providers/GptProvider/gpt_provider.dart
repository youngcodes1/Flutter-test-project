import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/Services/gpt_service.dart';
import 'package:http/http.dart' as http;

class GptProvider extends ChangeNotifier {
  GptService gptService = GptService();
  bool _isLoading = false;

  bool get loading => _isLoading;

  sendMessage(
    String message,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();

      Map<String, dynamic> input = {
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': message}
        ],
        'temperature': 0.7,
      };
      http.Response? res = await gptService.searchChat(input);
      _isLoading = false;

      if (res!.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception('failed to send message:${res.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
      _isLoading = false;
    }
  }
}
