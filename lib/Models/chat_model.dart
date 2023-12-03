class ChatModel {
  final String? userid;
  final String? role;
  final String? answer;
  final String? question;
  bool isFavorite;
  final DateTime? createdDateTime;

  ChatModel({
    this.userid,
    this.role,
    this.question,
    this.answer,
    this.isFavorite = false,
    this.createdDateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'role': role,
      'answer': answer,
      'question': question,
      'isFavorite': isFavorite ? 1 : 0,
      'createdDateTime': createdDateTime,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      userid: map['userid'],
      role: map['role'],
      question: map['question'],
      answer: map['answer'],
      isFavorite: map['isFavorite'] == 1,
      createdDateTime: map['createdDateTime'],
    );
  }
}
