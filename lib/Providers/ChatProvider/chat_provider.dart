import 'package:flutter/material.dart';

import '../../Models/chat_model.dart';
import '../../Services/chat_service.dart';

class ChatProvider extends ChangeNotifier {
  final ChatService chatService = ChatService();
  List<String> _messages = [];
  List<String> get messages => _messages;

  bool _isLoading = false;
  bool get loading => _isLoading;

  Future<void> sendMessageAndGetResponse(String message) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await chatService.messageResponse(message);

      _isLoading = false;
      notifyListeners();

      if (response != null) {
        _messages.add(response);
        print('Received response: $response');
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
      _isLoading = false;

      notifyListeners();
    }
  }
}
