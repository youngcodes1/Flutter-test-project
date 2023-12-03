class ChatModel {
  final int? id;
  final String? role;
  final String? answer;
  final String? question;
  bool isFavorite;
  final String? createdDateTime;

  ChatModel({
    this.id,
    this.role,
    this.question,
    this.answer,
    this.isFavorite = false,
    this.createdDateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'answer': answer,
      'question': question,
      'isFavorite': isFavorite ? 1 : 0,
      'createdDateTime': createdDateTime,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'],
      role: map['role'],
      question: map['question'],
      answer: map['answer'],
      isFavorite: map['isFavorite'] == 1,
      createdDateTime: map['createdDateTime'],
    );
  }
}
