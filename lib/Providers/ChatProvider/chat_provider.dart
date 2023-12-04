import 'package:flutter/material.dart';
import 'package:flutter_test_project/Core/BoxStorage/boxstorage.dart';
import 'package:flutter_test_project/Db/chat_dbhelper/chat_dbhelper.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

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
      debugPrint(response);

      _isLoading = false;
      notifyListeners();

      if (response != null) {
        final date = DateTime.now();
        final getuserId = await BoxStorage.getUsername();

        await _chatDatabaseHelper.insertMessage(
            questions: message,
            answer: response.toString(),
            createdAt: date.toString(),
            isFavorite: 0,
            userId: getuserId.toString());

        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<List<ChatModel>> getAllHistory() async {
    try {
      _isLoading = true;
      notifyListeners();
      final List<ChatModel> historyList =
          await _chatDatabaseHelper.getHistory();
      _isLoading = false;
      _messages = historyList;
      notifyListeners();
      return historyList;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  markFavorite(int id) async {
    try {
      await _chatDatabaseHelper.markAsFavorite(id);
      notifyListeners();
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.success,
        text: 'Favorite added Successfully!',
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> removeFromFavorites(int chatId) async {
    try {
      await _chatDatabaseHelper.removeFromFavorites(chatId);
      notifyListeners();
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.success,
        text: 'Favorite deleted Successfully!',
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<ChatModel>> getAllFavorites() async {
    try {
      _isLoading = true;
      notifyListeners();
      _favorites = await _chatDatabaseHelper.getFavorites();
      _isLoading = false;
      return _favorites;
    } catch (e) {
      debugPrint(e.toString());
      return [];
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
