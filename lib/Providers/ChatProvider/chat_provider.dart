import 'package:flutter/material.dart';
import 'package:flutter_test_project/Core/BoxStorage/boxstorage.dart';
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
  List<ChatModel> _todayMessages = [];
  List<ChatModel> get todayMessages => _todayMessages;

  Future<void> sendMessageAndGetResponse(String message) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await chatService.messageResponse(message);

      _isLoading = false;
      notifyListeners();

      if (response != null) {
        _messages.add(response);

        final date = DateTime.now();
        final getuserId = await BoxStorage.getUsername();
        ChatModel chat = ChatModel(
            question: message,
            answer: response,
            createdDateTime: date,
            userid: getuserId);
        _chatDatabaseHelper.insertMessage(chat);
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
      _messages = historyList;
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

  Future<List<ChatModel>> fetchTodayMessages() async {
    try {
      _isLoading = true;
      notifyListeners();
      final List<ChatModel> todayMessage =
          await _chatDatabaseHelper.getTodayMessages();
      _todayMessages = todayMessage;
      _isLoading = false;
      return todayMessage;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
