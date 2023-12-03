class ChatModel {
  final String? userid;
  // final String? role;
  final String? answer;
  final String? question;
  final int? isFavorite;
  final String? createdDateTime;

  ChatModel({
    this.userid,
    // this.role,
    this.question,
    this.answer,
    this.isFavorite,
    this.createdDateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      // 'role': role,
      'answer': answer,
      'question': question,
      'isFavorite': isFavorite,
      'createdDateTime': createdDateTime,
    };
  }

  static ChatModel fromMap(Map<String, dynamic> map) {
    return ChatModel(
      userid: map['userid'],
      // role: map['role'],
      question: map['question'],
      answer: map['answer'],
      isFavorite: map['isFavorite'],
      createdDateTime: map['createdDateTime'],
    );
  }
}
