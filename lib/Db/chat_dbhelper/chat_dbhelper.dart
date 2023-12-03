import 'package:flutter_test_project/Models/chat_model.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class ChatDatabaseHelper {
  ChatDatabaseHelper.privateConstructor();
  static final ChatDatabaseHelper instance =
      ChatDatabaseHelper.privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, 'chats.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE chat (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userid TEXT,
            question TEXT ,
            answer TEXT,
            createdDateTime TEXT,
            isFavorite INTEGER
          )
          ''');
  }

  insertMessage({
    required String userId,
    required String questions,
    required String answer,
    required String createdAt,
    required isFavorite,
  }) async {
    final db = await database;
    return db.insert('chat', {
      "userid": userId,
      "question": questions,
      "answer": answer,
      "createdDateTime": createdAt,
      "isFavorite": isFavorite,
    });
  }

  Future<List<ChatModel>> getHistory() async {
    final db = await database;
    final maps = await db.query('chat');
    return List.generate(maps.length, (i) {
      return ChatModel.fromMap(maps[i]);
    });
  }

  Future<List<ChatModel>> getFavorites() async {
    final db = await database;
    final maps = await db.query(
      'chat',
      where: 'isFavorite = ?',
      whereArgs: [1],
      orderBy: 'createdDateTime DESC ',
    );
    return List.generate(maps.length, (i) {
      return ChatModel.fromMap(maps[i]);
    });
  }

  Future<void> markAsFavorite(int chatId) async {
    final db = await database;
    await db.update(
      'chat',
      {'isFavorite': 1},
      where: 'id = ?',
      whereArgs: [chatId],
    );
  }

  Future<List<ChatModel>> getTodayMessages() async {
    final db = await database;
    final now = DateTime.now();
    List<ChatModel> chatModel = [];
    final today = DateFormat('yMMMd').format(now);
    final maps = await db.query(
      'chat',
    );
    print(maps);
    for (var chat in maps) {
      if (DateFormat("yMMMd")
              .format(DateTime.parse(chat["createdDateTime"].toString())) ==
          today) {
        chatModel.add(ChatModel.fromMap(chat));
      }
    }
    // return List.generate(maps.length, (i) {
    //   return ChatModel.fromMap(maps[i]);
    // });
    return chatModel;
  }
}
