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
    int? id,
    required String userId,
    required String questions,
    required String answer,
    required String createdAt,
    required isFavorite,
  }) async {
    final db = await database;
    return db.insert('chat', {
      "id": id,
      "userid": userId,
      "question": questions,
      "answer": answer,
      "createdDateTime": createdAt,
      "isFavorite": isFavorite,
    });
  }

  Future<List<ChatModel>> getHistory(String userId) async {
    final db = await database;
    final maps = await db.query('chat',
        where: 'userid = ?',
        whereArgs: [userId],
        orderBy: 'createdDateTime DESC');
    return List.generate(maps.length, (i) {
      return ChatModel.fromMap(maps[i]);
    });
  }

  Future<List<ChatModel>> getFavorites(String userId) async {
    final db = await database;
    final maps = await db.query(
      'chat',
      where: 'userid = ? AND isFavorite = ?',
      whereArgs: [userId, 1],
      orderBy: 'createdDateTime DESC ',
    );
    return List.generate(maps.length, (i) {
      return ChatModel.fromMap(maps[i]);
    });
  }

  Future<void> markAsFavorite(int id) async {
    final db = await database;
    await db.update(
      'chat',
      {'isFavorite': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> removeFromFavorites(int id) async {
    final db = await database;
    await db.update(
      'chat',
      {'isFavorite': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ChatModel>> getTodayMessages(String userId) async {
    final db = await database;
    final now = DateTime.now();
    List<ChatModel> chatModel = [];
    final today = DateFormat('yMMMd').format(now);
    final maps = await db.query(
      'chat',
      where: 'userid = ?',
      whereArgs: [userId],
    );

    for (var chat in maps) {
      if (DateFormat("yMMMd")
              .format(DateTime.parse(chat["createdDateTime"].toString())) ==
          today) {
        chatModel.add(ChatModel.fromMap(chat));
      }
    }

    return chatModel;
  }
}
