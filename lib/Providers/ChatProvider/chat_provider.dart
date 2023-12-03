import 'package:flutter/material.dart';
import 'package:flutter_test_project/Db/chat_dbhelper/chat_dbhelper.dart';

import '../../Models/chat_model.dart';
import '../../Services/chat_service.dart';

class ChatProvider extends ChangeNotifier {
  final ChatService chatService = ChatService();
  final ChatDatabaseHelper _chatDatabaseHelper = ChatDatabaseHelper.instance;
  bool _isLoading = false;
  bool get loading => _isLoading;
  List<ChatModel> _messages = [];
  List<ChatModel> get messages => _messages;
  List<ChatModel> _history = [];
  List<ChatModel> get history => _history;
  List<ChatModel> _favorites = [];
  List<ChatModel> get favorites => _favorites;

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

  getAllHistory() async {
    try {
      _isLoading = true;
      notifyListeners();
      final List<ChatModel> historyList =
          await _chatDatabaseHelper.getHistory();
      _isLoading = false;
      _history = historyList;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  markFavorite(int id) async {
    try {
      await _chatDatabaseHelper.markAsFavorite(id);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getAllFavorites() async {
    try {
      _isLoading = true;
      notifyListeners();
      _favorites = await _chatDatabaseHelper.getFavorites();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
