import 'package:flutter_test_project/Models/chat_model.dart';
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
          CREATE TABLE chats (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userid INTEGER,
            question TEXT ,
            answer TEXT,
            isFavorite INTEGER DEFAULT 0,


            
          )
          ''');
  }

  insertMessage(ChatModel chat) async {
    final db = await database;
    return db.insert('chats', chat.toMap());
  }
}
