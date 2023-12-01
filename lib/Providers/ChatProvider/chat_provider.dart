import 'package:flutter/material.dart';
import 'package:flutter_test_project/Services/chat_service.dart';

class ChatProvider extends ChangeNotifier {
  final ChatService _service = ChatService();
  List<Map<String, String>> get messages => _service.messages;
  Future<String> sendMessage(String message) async {
    final response = await _service.sendMessage(message);
    notifyListeners();
    return response;
  }
}
