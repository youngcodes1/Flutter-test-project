class ChatModel {
  final int? id;
  final String? role;
  final String? answer;
  final String? question;
  bool isFavorite;

  ChatModel(
      {this.id,
      this.role,
      this.question,
      this.answer,
      this.isFavorite = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'answer': answer,
      'question': question,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'],
      role: map['role'],
      question: map['question'],
      answer: map['answer'],
      isFavorite: map['isFavorite'] == 1,
    );
  }
}
