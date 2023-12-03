class ChatModel {
  final int? id;
  final String? userid;

  final String? answer;
  final String? question;
  final int? isFavorite;
  final String? createdDateTime;

  ChatModel({
    this.id,
    this.userid,
    this.question,
    this.answer,
    this.isFavorite,
    this.createdDateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userid': userid,
      'answer': answer,
      'question': question,
      'isFavorite': isFavorite,
      'createdDateTime': createdDateTime,
    };
  }

  static ChatModel fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'],
      userid: map['userid'],
      question: map['question'],
      answer: map['answer'],
      isFavorite: map['isFavorite'],
      createdDateTime: map['createdDateTime'],
    );
  }
}
